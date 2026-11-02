-- Phase 3: blanket 18% GST assumption for every product variant.
-- This is the business rule requested for this prototype. Confirm applicable
-- tax treatment with your CA before using for statutory invoices.
alter table public.product_variants
  add column if not exists gst_rate_percent numeric(7,3);

update public.product_variants
set gst_rate_percent = 18
where gst_rate_percent is null;

alter table public.product_variants
  alter column gst_rate_percent set default 18,
  alter column gst_rate_percent set not null;

alter table public.product_variants
  drop constraint if exists product_variants_gst_rate_percent_check;

alter table public.product_variants
  add constraint product_variants_gst_rate_percent_check
  check (gst_rate_percent = 18);

comment on column public.product_variants.gst_rate_percent is
  'Kwik Prints prototype policy: blanket 18% GST rate for all variants.';
