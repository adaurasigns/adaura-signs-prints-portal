# AdAura Signs & Prints Portal — Phase 2 foundation

## Confirmed product decisions

- Customer registration: both B2B and B2C.
- Checkout: wallet and direct Razorpay payment.
- Pricing: separate B2B and B2C rules.

## Included in this package

- Original Claude prototype retained as `index.html` (still a preview only; it still contains Claude-specific calls).
- Supabase migration for profiles, B2B/B2C customer types, B2B settings, B2C discount tiers, product catalogue, orders, payment records, append-only wallet ledger and private artwork bucket.
- B2B/B2C pure pricing calculation module with automated tests.
- Pricing policy and configuration checklist.
- Environment variable example.

## Security design

- B2B signups default to `pending` approval; B2C signups default to `approved`.
- Customers cannot self-promote to admin, change their customer type after registration, or approve their own B2B account.
- Customers cannot directly write orders, wallet ledger entries or payment records.
- Wallet balance is the sum of posted ledger entries; no editable balance column is used.
- Artwork bucket is private; the Edge Function must validate the file extension, actual size (20 MB maximum), authenticated owner and object path.
- Razorpay payment success must be verified server-side (signature + webhook) before an order is marked paid or wallet funds are credited.
- Direct payment and wallet payment are separate checkout choices. A future mixed/partial payment feature can be added if explicitly required.

## Important pricing behavior

- B2B starts with the prototype's 20% markup and ₹50 minimum addition as editable defaults.
- B2C has no active discounts or prices until verified retail/list prices and discount tiers are entered by an admin. Discounts are capped by a minimum gross-margin floor.
- Supplier and customer prices are treated as GST-inclusive for this quote engine. Invoice tax breakup requires product tax-rate configuration before launch.

## Still to implement / configure

1. Create a Supabase project and apply `supabase/migrations/202611020001_initial_schema.sql`.
2. Load verified products/variants and supplier costs. Several prototype categories are placeholders and must not be treated as approved prices.
3. Configure B2C retail prices and discount tiers; confirm B2B rates, rounding and category exceptions.
4. Implement and deploy Supabase Edge Functions for profile bootstrap, quote calculation, transactional order creation, wallet top-up, Razorpay order creation, payment verification/webhooks and admin status updates.
5. Replace Claude-specific frontend calls with Supabase Auth/Storage/Edge Function calls and add B2B/B2C signup selection plus payment-method selection.
6. Add GST rate mapping, invoice generation, refunds/cancellations and admin audit log.
7. Run security, payment, duplicate-webhook, concurrency, upload and order lifecycle tests; then deploy to Vercel.

## Run pricing tests locally

Requires Node.js 18+:

```bash
npm run test:pricing
```

This package is a development foundation, not a deployed backend and not ready to accept live orders or money.
