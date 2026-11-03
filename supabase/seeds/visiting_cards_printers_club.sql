-- AdAura initial catalogue import: Printers Club Visiting Cards rate list.
-- Source rates are GST-inclusive. The GST 18% value reflects the prototype assumption;
-- verify tax classification with the CA before statutory invoicing.
-- Product packs/quantities are preserved from the supplier list.

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-METAL','Metal Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 50 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-METAL-001','1 colour text/logo','{"pack_size":"50 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,3043.00,18,'50 cards',true
from public.products p where p.sku='VC-METAL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-METAL-002','2 colour text/logo','{"pack_size":"50 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,3138.00,18,'50 cards',true
from public.products p where p.sku='VC-METAL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-METAL-003','3 colour text/logo','{"pack_size":"50 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,3232.00,18,'50 cards',true
from public.products p where p.sku='VC-METAL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-METAL-004','4 colour text/logo','{"pack_size":"50 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,3326.00,18,'50 cards',true
from public.products p where p.sku='VC-METAL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-METAL-005','5 colour text/logo','{"pack_size":"50 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,3421.00,18,'50 cards',true
from public.products p where p.sku='VC-METAL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-METAL-006','6 colour text/logo','{"pack_size":"50 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,3515.00,18,'50 cards',true
from public.products p where p.sku='VC-METAL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-500-VELVET','500 GSM Velvet Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 500 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-500-VELVET-001','500 GSM + Velvet','{"pack_size":"500 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1108.00,18,'500 cards',true
from public.products p where p.sku='VC-500-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-500-VELVET-002','500 GSM + Velvet + UV + Die Cut','{"pack_size":"500 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1250.00,18,'500 cards',true
from public.products p where p.sku='VC-500-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-500-VELVET-003','500 GSM + Velvet + UV + Foil + Die Cut','{"pack_size":"500 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1486.00,18,'500 cards',true
from public.products p where p.sku='VC-500-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-500-VELVET-004','500 GSM + Velvet + UV','{"pack_size":"500 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1250.00,18,'500 cards',true
from public.products p where p.sku='VC-500-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-500-VELVET-005','500 GSM + Velvet + UV + Foil + Customized Die Cut','{"pack_size":"500 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1580.00,18,'500 cards',true
from public.products p where p.sku='VC-500-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-500-MATT','500 GSM Matt Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 500 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-500-MATT-001','500 GSM + Matt + UV + Die Cut','{"pack_size":"500 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1132.00,18,'500 cards',true
from public.products p where p.sku='VC-500-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-500-MATT-002','500 GSM + Matt + UV + Foil + Die Cut','{"pack_size":"500 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1368.00,18,'500 cards',true
from public.products p where p.sku='VC-500-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-800-GOLD-GLOSS','800 Micron Gold + Gloss','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 100 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-001','Spot UV not required; no foil','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Not required","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1156.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-002','Spot UV not required; Gold foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Gold - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-003','Spot UV not required; Gold foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Gold - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-004','Spot UV not required; Silver foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Silver - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-005','Spot UV not required; Silver foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Silver - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-006','Spot UV not required; Red foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Red - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-007','Spot UV not required; Red foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Red - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-008','Spot UV not required; Green foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Green - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-009','Spot UV not required; Green foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Green - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-010','Spot UV not required; Blue foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Blue - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-011','Spot UV not required; Blue foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"Not required","foil":"Blue - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-012','Spot UV 1 side; Gold foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Gold - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-013','Spot UV 1 side; Silver foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Silver - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-014','Spot UV 1 side; Silver foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Silver - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-015','Spot UV 1 side; Red foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Red - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-016','Spot UV 1 side; Red foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Red - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-017','Spot UV 1 side; Green foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Green - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-018','Spot UV 1 side; Green foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Green - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-019','Spot UV 1 side; Blue foil 1 side','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Blue - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-GOLD-GLOSS-020','Spot UV 1 side; Blue foil 2 sides','{"material":"800 Micron Gold + Gloss","spot_uv":"1 side only","foil":"Blue - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-GOLD-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-800-MATT','800 Micron + Matt','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 100 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-001','Spot UV not required; no foil','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Not required","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1156.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-002','Spot UV not required; Gold foil 1 side','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Gold - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-003','Spot UV not required; Gold foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Gold - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-004','Spot UV not required; Silver foil 1 side','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Silver - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-005','Spot UV not required; Silver foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Silver - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-006','Spot UV not required; Red foil 1 side','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Red - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-007','Spot UV not required; Red foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Red - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-008','Spot UV not required; Green foil 1 side','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Green - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-009','Spot UV not required; Green foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Green - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-010','Spot UV not required; Blue foil 1 side','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Blue - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-011','Spot UV not required; Blue foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"Not required","foil":"Blue - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-012','Spot UV 1 side; Gold foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Gold - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-013','Spot UV 1 side; Silver foil 1 side','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Silver - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-014','Spot UV 1 side; Silver foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Silver - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-015','Spot UV 1 side; Red foil 1 side','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Red - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-016','Spot UV 1 side; Red foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Red - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-017','Spot UV 1 side; Green foil 1 side','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Green - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-018','Spot UV 1 side; Green foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Green - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-019','Spot UV 1 side; Blue foil 1 side','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Blue - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-MATT-020','Spot UV 1 side; Blue foil 2 sides','{"material":"800 Micron + Matt","spot_uv":"1 side only","foil":"Blue - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-800-VELVET','800 Micron + Velvet','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 100 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-001','Spot UV not required; no foil','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Not required","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1156.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-002','Spot UV not required; Gold foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Gold - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-003','Spot UV not required; Gold foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Gold - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-004','Spot UV not required; Silver foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Silver - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-005','Spot UV not required; Silver foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Silver - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-006','Spot UV not required; Red foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Red - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-007','Spot UV not required; Red foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Red - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-008','Spot UV not required; Green foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Green - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-009','Spot UV not required; Green foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Green - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-010','Spot UV not required; Blue foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Blue - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-011','Spot UV not required; Blue foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"Not required","foil":"Blue - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-012','Spot UV 1 side; Gold foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Gold - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-013','Spot UV 1 side; Silver foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Silver - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-014','Spot UV 1 side; Silver foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Silver - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-015','Spot UV 1 side; Red foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Red - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-016','Spot UV 1 side; Red foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Red - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-017','Spot UV 1 side; Green foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Green - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-018','Spot UV 1 side; Green foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Green - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-019','Spot UV 1 side; Blue foil 1 side','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Blue - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-VELVET-020','Spot UV 1 side; Blue foil 2 sides','{"material":"800 Micron + Velvet","spot_uv":"1 side only","foil":"Blue - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-VELVET'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-800-SILVER-GLOSS','800 Micron Silver + Gloss','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 100 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-001','Spot UV not required; no foil','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Not required","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1156.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-002','Spot UV not required; Gold foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Gold - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-003','Spot UV not required; Gold foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Gold - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-004','Spot UV not required; Silver foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Silver - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-005','Spot UV not required; Silver foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Silver - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-006','Spot UV not required; Red foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Red - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-007','Spot UV not required; Red foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Red - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-008','Spot UV not required; Green foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Green - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-009','Spot UV not required; Green foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Green - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-010','Spot UV not required; Blue foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Blue - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1510.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-011','Spot UV not required; Blue foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"Not required","foil":"Blue - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-012','Spot UV 1 side; Gold foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Gold - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-013','Spot UV 1 side; Silver foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Silver - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-014','Spot UV 1 side; Silver foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Silver - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-015','Spot UV 1 side; Red foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Red - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-016','Spot UV 1 side; Red foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Red - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-017','Spot UV 1 side; Green foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Green - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-018','Spot UV 1 side; Green foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Green - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-019','Spot UV 1 side; Blue foil 1 side','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Blue - 1 side","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1628.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-800-SILVER-GLOSS-020','Spot UV 1 side; Blue foil 2 sides','{"material":"800 Micron Silver + Gloss","spot_uv":"1 side only","foil":"Blue - 2 sides","pack_size":"100 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1864.00,18,'100 cards',true
from public.products p where p.sku='VC-800-SILVER-GLOSS'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-180','180 Micron Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-180-001','180 Micron NT · single side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,335.00,18,'1000 cards',true
from public.products p where p.sku='VC-180'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-180-002','180 Micron NT · both sides','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,382.00,18,'1000 cards',true
from public.products p where p.sku='VC-180'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-180-003','180 Micron NT + Gloss UV · single side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,359.00,18,'1000 cards',true
from public.products p where p.sku='VC-180'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-180-004','180 Micron NT + Gloss UV · both sides','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,406.00,18,'1000 cards',true
from public.products p where p.sku='VC-180'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-180-005','180 Micron NT + Drip-Off · single side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,406.00,18,'1000 cards',true
from public.products p where p.sku='VC-180'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-180-006','180 Micron NT + Drip-Off · both sides','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,453.00,18,'1000 cards',true
from public.products p where p.sku='VC-180'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-MATT-UV','Matt + UV Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-MATT-UV-001','Single side printing + single side UV','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,872.00,18,'1000 cards',true
from public.products p where p.sku='VC-MATT-UV'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-MATT-UV-002','Both side printing + single side UV','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,896.00,18,'1000 cards',true
from public.products p where p.sku='VC-MATT-UV'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-MATT-UV-003','Both side printing + both side UV','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,1014.00,18,'1000 cards',true
from public.products p where p.sku='VC-MATT-UV'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-MATT','Matt Lamination Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-MATT-001','Matt lamination · single side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,565.00,18,'1000 cards',true
from public.products p where p.sku='VC-MATT'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-MATT-TEXTURE','Matt + Texture Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-MATT-TEXTURE-001','Matt + Texture · single side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,801.00,18,'1000 cards',true
from public.products p where p.sku='VC-MATT-TEXTURE'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-GLOSS-TEXTURE','Gloss + Texture Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-TEXTURE-001','Gloss + Texture · single side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,424.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-TEXTURE'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-GLOSS-LAM','Gloss Lamination Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-LAM-001','Gloss lamination · 1 side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,235.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-LAM'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-LAM-002','Gloss lamination · 1 side + black back','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,242.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-LAM'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-LAM-003','Gloss lamination · 2 sides','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,329.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-LAM'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-GLOSS-UV','Gloss UV Coated Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-UV-001','Gloss UV coated · 1 side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,223.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-UV'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-UV-002','Gloss UV coated · 1 side + black back','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,230.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-UV'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-UV-003','Gloss UV coated · 2 sides','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,317.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-UV'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-WITHOUT-COATING','Without Coating Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-WITHOUT-COATING-001','Without coating · single side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,211.00,18,'1000 cards',true
from public.products p where p.sku='VC-WITHOUT-COATING'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-WITHOUT-COATING-002','Without coating · single side + black back','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,218.00,18,'1000 cards',true
from public.products p where p.sku='VC-WITHOUT-COATING'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-WITHOUT-COATING-003','Without coating · both sides','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,282.00,18,'1000 cards',true
from public.products p where p.sku='VC-WITHOUT-COATING'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-GLOSS-UV-SMALL','Gloss UV Coated Small Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-UV-SMALL-001','Gloss UV coated small · 1 side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,199.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-UV-SMALL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-GLOSS-UV-SMALL-002','Gloss UV coated small · 1 side + black back','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,207.00,18,'1000 cards',true
from public.products p where p.sku='VC-GLOSS-UV-SMALL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.products (sku,name,category,description,active,sort_order)
values ('VC-WITHOUT-LAM-SMALL','Without Lamination Small Cards','Visiting Cards','Supplier catalogue variants. Supplier rates are GST-inclusive and represent 1000 cards.',true,10)
on conflict (sku) do update set name=excluded.name,category=excluded.category,description=excluded.description,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-WITHOUT-LAM-SMALL-001','Without lamination small · 1 side','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,188.00,18,'1000 cards',true
from public.products p where p.sku='VC-WITHOUT-LAM-SMALL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();

insert into public.product_variants (product_id,sku,variant_name,options,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
select p.id,'VC-WITHOUT-LAM-SMALL-002','Without lamination small · 1 side + black back','{"pack_size":"1000 cards","supplier_source":"Printers Club Visiting Cards Rate List"}'::jsonb,195.00,18,'1000 cards',true
from public.products p where p.sku='VC-WITHOUT-LAM-SMALL'
on conflict (sku) do update set product_id=excluded.product_id,variant_name=excluded.variant_name,options=excluded.options,supplier_rate_inclusive=excluded.supplier_rate_inclusive,gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=true,updated_at=now();
