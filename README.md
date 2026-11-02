# AdAura Signs & Prints — Portal source package

This package is a **development foundation**, not a deployed or fully functional ordering website.

## Included
- `index.html`: legacy UI prototype rebranded for AdAura; it still contains Claude-specific auth/database/storage calls and is not standalone.
- `supabase/migrations/`: initial database schema and pricing migration. These have **not** been applied to your Supabase project.
- `src/pricing.js`: pure B2B/B2C pricing calculation helpers. GST rate must be passed explicitly for each product/variant.
- `src/pricing.test.js`: automated pricing tests.
- `docs/PRICING_POLICY.md`: agreed prototype pricing assumptions.
- `BACKEND_PLAN.md`: backend implementation notes.

## Pricing assumptions
- Supplier catalogue rates are treated as GST-inclusive.
- B2C: 100% markup on supplier cost before GST, then add the applicable GST rate.
- B2B: add the greater of 20% of supplier-inclusive rate or ₹50 (initial agreed rule).
- The earlier blanket 18% assumption is a planning assumption only. Product GST classification/rates must be verified before issuing tax invoices.

## Run pricing tests
Requires Node.js 18+.

```bash
npm test
```

## Not yet completed
- The legacy frontend still calls `claude.use`; it is not connected to Supabase.
- Supabase migrations are not applied; Auth, Storage and database workflows are not configured.
- The selected final silver-and-gold logo has not been embedded in this archive.
- Customer registration, cart, order submission, admin dashboard, wallet and payment gateway are not ready for live use.
- No domain or deployment is configured.

**Do not use this package to accept live customer orders or payments.** Never commit Supabase service-role keys, database passwords, or payment gateway secrets.
