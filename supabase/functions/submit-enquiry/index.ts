// Supabase Edge Function: submit an authenticated quote enquiry.
// Price calculations happen here; supplier costs are never returned or trusted from the browser.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), { status, headers: { ...cors, "Content-Type": "application/json" } });
const round2 = (n: number) => Math.round((n + Number.EPSILON) * 100) / 100;

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Method not allowed" }, 405);

  const authHeader = req.headers.get("Authorization");
  if (!authHeader) return json({ error: "Please sign in before submitting an enquiry." }, 401);
  const url = Deno.env.get("SUPABASE_URL");
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY");
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!url || !anonKey || !serviceKey) return json({ error: "Enquiry service is not configured." }, 503);

  const authClient = createClient(url, anonKey, {
    global: { headers: { Authorization: authHeader } },
    auth: { persistSession: false, autoRefreshToken: false },
  });
  const { data: authData, error: authError } = await authClient.auth.getUser();
  if (authError || !authData.user) return json({ error: "Your session has expired. Please sign in again." }, 401);

  let body: Record<string, unknown>;
  try { body = await req.json(); } catch { return json({ error: "Invalid request body." }, 400); }
  const items = body.items;
  if (!Array.isArray(items) || items.length < 1 || items.length > 50) {
    return json({ error: "Add between 1 and 50 catalogue items." }, 400);
  }

  const customerNotes = typeof body.customer_notes === "string" ? body.customer_notes.trim().slice(0, 3000) : "";
  const phone = typeof body.contact_phone === "string" ? body.contact_phone.trim().slice(0, 30) : "";
  const delivery = typeof body.delivery_location === "string" ? body.delivery_location.trim().slice(0, 200) : "";
  const idempotencyKey = typeof body.idempotency_key === "string" && body.idempotency_key.length <= 100
    ? body.idempotency_key : crypto.randomUUID();

  const admin = createClient(url, serviceKey, { auth: { persistSession: false, autoRefreshToken: false } });
  const { data: profile, error: profileError } = await admin.from("profiles")
    .select("customer_type,account_status").eq("id", authData.user.id).maybeSingle();
  if (profileError) return json({ error: "Could not load your customer profile." }, 500);
  if (!profile) return json({ error: "Complete your customer profile before submitting an enquiry." }, 403);
  if (profile.account_status !== "approved") return json({ error: "Your account is awaiting approval. Please contact AdAura." }, 403);

  const requested = items.map((item: Record<string, unknown>) => ({
    variant_id: String(item?.variant_id || ""),
    quantity: Number(item?.quantity),
  }));
  if (requested.some((x) => !/^[0-9a-f-]{36}$/i.test(x.variant_id) || !Number.isInteger(x.quantity) || x.quantity < 1 || x.quantity > 10000)) {
    return json({ error: "One or more selected variants or quantities are invalid." }, 400);
  }

  const ids = [...new Set(requested.map((x) => x.variant_id))];
  const { data: variants, error: variantError } = await admin.from("product_variants")
    .select("id,product_id,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit")
    .in("id", ids).eq("active", true);
  if (variantError) return json({ error: "Could not verify the selected catalogue items." }, 500);
  if (!variants || variants.length !== ids.length) return json({ error: "A selected product is no longer available. Refresh the catalogue." }, 409);

  let markup = 20, minimum = 50;
  if (profile.customer_type === "b2b") {
    const { data: settings, error } = await admin.from("b2b_pricing_settings")
      .select("markup_percent,minimum_addition,enabled").eq("id", true).maybeSingle();
    if (error) return json({ error: "Could not load business pricing." }, 500);
    if (settings) {
      if (!settings.enabled) return json({ error: "Business pricing is temporarily unavailable." }, 503);
      markup = Number(settings.markup_percent);
      minimum = Number(settings.minimum_addition);
    }
  }

  const variantMap = new Map(variants.map((v) => [v.id, v]));
  const snapshots = [];
  let subtotal = 0;
  for (const request of requested) {
    const v = variantMap.get(request.variant_id)!;
    const supplierInclusive = Number(v.supplier_rate_inclusive);
    const gst = Number(v.gst_rate_percent ?? 18);
    let exGst: number, gstAmount: number, inclusive: number;
    if (profile.customer_type === "b2b") {
      inclusive = round2(supplierInclusive + Math.max(supplierInclusive * markup / 100, minimum));
      exGst = round2(inclusive / (1 + gst / 100));
      gstAmount = round2(inclusive - exGst);
    } else {
      const costExGst = round2(supplierInclusive / (1 + gst / 100));
      exGst = round2(costExGst * 2);
      gstAmount = round2(exGst * gst / 100);
      inclusive = round2(exGst + gstAmount);
    }
    const lineTotal = round2(inclusive * request.quantity);
    subtotal = round2(subtotal + lineTotal);
    snapshots.push({
      variant_id: v.id, product_id: v.product_id, variant_name: v.variant_name,
      options: v.options, quantity_unit: v.quantity_unit, quantity: request.quantity,
      gst_rate_percent: gst, unit_price_ex_gst: exGst, unit_gst: gstAmount,
      unit_price_inclusive: inclusive, line_total_inclusive: lineTotal,
    });
  }

  const { data: existing } = await admin.from("enquiries").select("id,enquiry_number,status,subtotal_inclusive")
    .eq("customer_id", authData.user.id).eq("idempotency_key", idempotencyKey).maybeSingle();
  if (existing) return json({ enquiry: existing, idempotent_replay: true });

  const { data: enquiry, error: insertError } = await admin.from("enquiries").insert({
    customer_id: authData.user.id,
    customer_type_at_enquiry: profile.customer_type,
    items: snapshots,
    subtotal_inclusive: subtotal,
    customer_notes: customerNotes || null,
    contact_phone: phone || null,
    delivery_location: delivery || null,
    idempotency_key: idempotencyKey,
  }).select("id,enquiry_number,status,subtotal_inclusive,created_at").single();

  if (insertError) {
    if (insertError.code === "23505") return json({ error: "This enquiry was already submitted. Refresh your enquiry list." }, 409);
    return json({ error: "Could not save your enquiry. Please try again." }, 500);
  }
  return json({ enquiry });
});
