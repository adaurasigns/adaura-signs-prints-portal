-- AdAura Signs & Prints Portal: Supabase foundation.
-- Apply only to a NEW Supabase project after review. Never paste service-role
-- secrets into browser code. All money columns are GST-inclusive INR values.

create extension if not exists pgcrypto;

do $$ begin
  create type public.customer_type as enum ('b2b', 'b2c');
exception when duplicate_object then null; end $$;
do $$ begin
  create type public.account_status as enum ('pending', 'approved', 'rejected', 'suspended');
exception when duplicate_object then null; end $$;
do $$ begin
  create type public.order_status as enum ('submitted', 'artwork_review', 'artwork_approved', 'in_production', 'ready', 'dispatched', 'completed', 'cancelled');
exception when duplicate_object then null; end $$;
do $$ begin
  create type public.payment_method as enum ('wallet', 'razorpay');
exception when duplicate_object then null; end $$;
do $$ begin
  create type public.payment_status as enum ('pending', 'paid', 'failed', 'refunded', 'partially_refunded');
exception when duplicate_object then null; end $$;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  business_name text,
  phone text,
  email text,
  customer_type public.customer_type not null default 'b2c',
  account_status public.account_status not null default 'approved',
  gst_number text,
  billing_address text,
  shipping_address text,
  role text not null default 'customer' check (role in ('customer', 'admin')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  sku text unique,
  name text not null,
  category text not null,
  description text,
  active boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.product_variants (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  sku text unique,
  variant_name text not null,
  options jsonb not null default '{}'::jsonb,
  supplier_rate_inclusive numeric(12,2) not null check (supplier_rate_inclusive >= 0),
  b2c_list_price_inclusive numeric(12,2) check (b2c_list_price_inclusive is null or b2c_list_price_inclusive >= supplier_rate_inclusive),
  quantity_unit text not null default 'unit',
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (product_id, variant_name, options)
);

-- B2B uses the prototype's initial 20% / Rs 50 rule as a starting setting.
-- Admin can change these later. B2C discount bands are separate and start empty
-- until retail list prices and approved margin floors are loaded.
create table if not exists public.b2b_pricing_settings (
  id boolean primary key default true check (id),
  markup_percent numeric(7,3) not null default 20 check (markup_percent >= 0),
  minimum_addition numeric(12,2) not null default 50 check (minimum_addition >= 0),
  enabled boolean not null default true,
  updated_at timestamptz not null default now()
);
insert into public.b2b_pricing_settings (id) values (true) on conflict (id) do nothing;

create table if not exists public.b2c_discount_tiers (
  id uuid primary key default gen_random_uuid(),
  min_gross_margin_percent numeric(7,3) not null check (min_gross_margin_percent >= 0 and min_gross_margin_percent < 100),
  max_gross_margin_percent numeric(7,3) check (max_gross_margin_percent is null or max_gross_margin_percent <= 100),
  discount_percent numeric(7,3) not null check (discount_percent >= 0 and discount_percent <= 100),
  minimum_margin_after_discount_percent numeric(7,3) not null default 0 check (minimum_margin_after_discount_percent >= 0 and minimum_margin_after_discount_percent < 100),
  priority integer not null default 0,
  enabled boolean not null default true,
  created_at timestamptz not null default now(),
  check (max_gross_margin_percent is null or max_gross_margin_percent > min_gross_margin_percent)
);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  order_number bigint generated always as identity unique,
  customer_id uuid not null references public.profiles(id),
  customer_type_at_order public.customer_type not null,
  status public.order_status not null default 'submitted',
  payment_method public.payment_method not null,
  payment_status public.payment_status not null default 'pending',
  items jsonb not null,
  subtotal_inclusive numeric(12,2) not null check (subtotal_inclusive >= 0),
  discount_inclusive numeric(12,2) not null default 0 check (discount_inclusive >= 0),
  total_inclusive numeric(12,2) not null check (total_inclusive >= 0),
  pricing_snapshot jsonb not null default '{}'::jsonb,
  artwork_path text,
  customer_notes text,
  admin_notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Append-only wallet ledger. Balance = sum(amount) for posted rows.
create table if not exists public.wallet_transactions (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references public.profiles(id),
  amount numeric(12,2) not null check (amount <> 0),
  transaction_type text not null check (transaction_type in ('topup', 'order_debit', 'refund', 'adjustment')),
  status text not null default 'pending' check (status in ('pending', 'posted', 'failed', 'reversed')),
  idempotency_key text unique,
  provider text,
  provider_reference text,
  order_id uuid references public.orders(id),
  description text,
  created_at timestamptz not null default now(),
  unique (provider, provider_reference)
);

create table if not exists public.payment_records (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references public.profiles(id),
  order_id uuid references public.orders(id),
  purpose text not null check (purpose in ('order_payment', 'wallet_topup')),
  provider text not null default 'razorpay',
  provider_order_id text unique,
  provider_payment_id text unique,
  amount numeric(12,2) not null check (amount > 0),
  currency text not null default 'INR',
  status public.payment_status not null default 'pending',
  idempotency_key text not null unique,
  verified_at timestamptz,
  raw_event jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists orders_customer_created_idx on public.orders(customer_id, created_at desc);
create index if not exists wallet_customer_created_idx on public.wallet_transactions(customer_id, created_at desc);
create index if not exists products_category_sort_idx on public.products(category, sort_order);
create index if not exists variants_product_active_idx on public.product_variants(product_id, active);
create index if not exists payment_records_customer_created_idx on public.payment_records(customer_id, created_at desc);

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.profiles where id = auth.uid() and role = 'admin'); $$;

-- Customers cannot self-promote, switch B2B/B2C class, or approve their account.
create or replace function public.set_customer_signup_defaults()
returns trigger language plpgsql security definer set search_path = public
as $$
begin
  if auth.uid() is not null and not public.is_admin() then
    new.role := 'customer';
    if new.customer_type = 'b2b' then
      new.account_status := 'pending';
    else
      new.account_status := 'approved';
    end if;
  end if;
  return new;
end;
$$;
drop trigger if exists customer_signup_defaults_trigger on public.profiles;
create trigger customer_signup_defaults_trigger before insert on public.profiles
for each row execute function public.set_customer_signup_defaults();

create or replace function public.protect_profile_privileges()
returns trigger language plpgsql security definer set search_path = public
as $$
begin
  if auth.uid() is not null and not public.is_admin() then
    if new.role is distinct from old.role
      or new.customer_type is distinct from old.customer_type
      or new.account_status is distinct from old.account_status then
      raise exception 'Only an administrator can change role, customer type or account status';
    end if;
  end if;
  new.updated_at := now();
  return new;
end;
$$;
drop trigger if exists protect_profile_privileges_trigger on public.profiles;
create trigger protect_profile_privileges_trigger before update on public.profiles
for each row execute function public.protect_profile_privileges();

alter table public.profiles enable row level security;
alter table public.products enable row level security;
alter table public.product_variants enable row level security;
alter table public.b2b_pricing_settings enable row level security;
alter table public.b2c_discount_tiers enable row level security;
alter table public.orders enable row level security;
alter table public.wallet_transactions enable row level security;
alter table public.payment_records enable row level security;

create policy "read own profile or admin" on public.profiles for select to authenticated
using (id = auth.uid() or public.is_admin());
create policy "update own profile or admin" on public.profiles for update to authenticated
using (id = auth.uid() or public.is_admin()) with check (id = auth.uid() or public.is_admin());
create policy "insert own profile" on public.profiles for insert to authenticated
with check (id = auth.uid() and role = 'customer');

create policy "read active products" on public.products for select to authenticated using (active or public.is_admin());
create policy "read active variants" on public.product_variants for select to authenticated using (active or public.is_admin());
create policy "admins manage products" on public.products for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admins manage variants" on public.product_variants for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admins manage b2b pricing" on public.b2b_pricing_settings for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admins manage b2c tiers" on public.b2c_discount_tiers for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "read pricing settings" on public.b2b_pricing_settings for select to authenticated using (true);
create policy "read b2c discount tiers" on public.b2c_discount_tiers for select to authenticated using (enabled or public.is_admin());

create policy "customers read own orders" on public.orders for select to authenticated using (customer_id = auth.uid() or public.is_admin());
create policy "admins update orders" on public.orders for update to authenticated using (public.is_admin()) with check (public.is_admin());
-- No customer direct write policies for orders, wallet transactions or payments.
create policy "customers read own wallet ledger" on public.wallet_transactions for select to authenticated using (customer_id = auth.uid() or public.is_admin());
create policy "customers read own payments" on public.payment_records for select to authenticated using (customer_id = auth.uid() or public.is_admin());

-- Private artwork bucket. CDR MIME types vary, so enforce extension, 20 MB size,
-- and ownership in the upload Edge Function as well as these storage policies.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('artwork', 'artwork', false, 20971520, array['application/pdf', 'application/octet-stream'])
on conflict (id) do update set public = false, file_size_limit = 20971520;
create policy "customers upload own artwork" on storage.objects for insert to authenticated
with check (bucket_id = 'artwork' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "customers read own artwork or admin" on storage.objects for select to authenticated
using (bucket_id = 'artwork' and ((storage.foldername(name))[1] = auth.uid()::text or public.is_admin()));

-- IMPORTANT: Deploy transactional order/payment Edge Functions before accepting
-- real orders or money. Do not add client-side INSERT/UPDATE policies to ledger.
