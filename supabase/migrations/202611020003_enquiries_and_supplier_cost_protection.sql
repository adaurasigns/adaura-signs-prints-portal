-- AdAura Phase 4: secure customer enquiries and protect supplier costs.
-- Apply after 202611020001_initial_schema.sql and 202611020002_b2c_markup_before_gst.sql.

-- Supplier rates must never be directly readable by customer sessions.
drop policy if exists "read active variants" on public.product_variants;

create table if not exists public.enquiries (
  id uuid primary key default gen_random_uuid(),
  enquiry_number bigint generated always as identity unique,
  customer_id uuid not null references public.profiles(id),
  customer_type_at_enquiry public.customer_type not null,
  status text not null default 'new'
    check (status in ('new','reviewing','quoted','accepted','rejected','converted','closed')),
  items jsonb not null check (jsonb_typeof(items) = 'array'),
  subtotal_inclusive numeric(12,2) not null check (subtotal_inclusive >= 0),
  customer_notes text,
  contact_phone text,
  delivery_location text,
  idempotency_key text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (customer_id, idempotency_key)
);

create index if not exists enquiries_customer_created_idx
  on public.enquiries(customer_id, created_at desc);
create index if not exists enquiries_status_created_idx
  on public.enquiries(status, created_at desc);

alter table public.enquiries enable row level security;

create policy "customers read own enquiries or admin"
  on public.enquiries for select to authenticated
  using (customer_id = auth.uid() or public.is_admin());

-- Enquiries are inserted only by the submit-enquiry Edge Function using the
-- service role after verifying the JWT, account status, variants and prices.
-- No direct customer INSERT or UPDATE policy is intentionally created.
create policy "admins update enquiries"
  on public.enquiries for update to authenticated
  using (public.is_admin()) with check (public.is_admin());

comment on table public.enquiries is
  'Customer quote requests. Inserted server-side after server-side price calculation.';
