// Supabase Edge Function: authenticated, customer-specific catalogue.
// Deploy with JWT verification enabled. Never return supplier costs to browsers.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });

const round2 = (n: number) => Math.round((n + Number.EPSILON) * 100) / 100;

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Method not allowed" }, 405);

  const authHeader = req.headers.get("Authorization");
  if (!authHeader) return json({ error: "Sign in to view customer pricing." }, 401);

  const url = Deno.env.get("SUPABASE_URL");
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY");
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!url || !anonKey || !serviceKey) {
    return json({ error: "Catalogue service is not configured." }, 503);
  }

  const authClient = createClient(url, anonKey, {
    global: { headers: { Authorization: authHeader } },
    auth: { persistSession: false, autoRefreshToken: false },
  });
  const { data: authData, error: authError } = await authClient.auth.getUser();
  if (authError || !authData.user) return json({ error: "Your session is invalid. Please sign in again." }, 401);

  const admin = createClient(url, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const { data: profile, error: profileError } = await admin
    .from("profiles")
    .select("customer_type, account_status")
    .eq("id", authData.user.id)
    .maybeSingle();

  if (profileError) return json({ error: "Could not load your customer profile." }, 500);
  if (!profile) return json({ error: "Complete your customer profile to view pricing." }, 403);
  if (profile.account_status !== "approved") {
    return json({ error: profile.account_status === "pending"
      ? "Your business account is awaiting approval. Please contact AdAura."
      : "Your account is not currently approved." }, 403);
  }

  const [{ data: products, error: productError }, { data: variants, error: variantError }] =
    await Promise.all([
      admin.from("products").select("id,name,category,description,sort_order").eq("active", true).order("sort_order").order("name"),
      admin.from("product_variants").select("id,product_id,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit").eq("active", true),
    ]);

  if (productError || variantError) return json({ error: "Could not load the catalogue." }, 500);

  let b2bMarkup = 20;
  let b2bMinimum = 50;
  if (profile.customer_type === "b2b") {
    const { data: settings, error } = await admin
      .from("b2b_pricing_settings").select("markup_percent,minimum_addition,enabled").eq("id", true).maybeSingle();
    if (error) return json({ error: "Could not load business pricing." }, 500);
    if (settings) {
      if (!settings.enabled) return json({ error: "Business pricing is temporarily unavailable." }, 503);
      b2bMarkup = Number(settings.markup_percent);
      b2bMinimum = Number(settings.minimum_addition);
    }
  }

  const safeVariants = (variants || []).map((v) => {
    const supplierInclusive = Number(v.supplier_rate_inclusive);
    const gstRate = Number(v.gst_rate_percent ?? 18);
    let unitExGst: number;
    let unitGst: number;
    let unitInclusive: number;

    if (profile.customer_type === "b2b") {
      unitInclusive = round2(supplierInclusive + Math.max(supplierInclusive * b2bMarkup / 100, b2bMinimum));
      unitExGst = round2(unitInclusive / (1 + gstRate / 100));
      unitGst = round2(unitInclusive - unitExGst);
    } else {
      const costExGst = round2(supplierInclusive / (1 + gstRate / 100));
      unitExGst = round2(costExGst * 2);
      unitGst = round2(unitExGst * gstRate / 100);
      unitInclusive = round2(unitExGst + unitGst);
    }

    return {
      id: v.id,
      product_id: v.product_id,
      name: v.variant_name,
      options: v.options,
      quantity_unit: v.quantity_unit,
      gst_rate_percent: gstRate,
      unit_price_ex_gst: unitExGst,
      unit_gst: unitGst,
      unit_price_inclusive: unitInclusive,
    };
  });

  return json({
    customer_type: profile.customer_type,
    products: products || [],
    variants: safeVariants,
  });
});
