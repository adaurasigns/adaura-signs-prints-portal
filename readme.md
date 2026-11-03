# AdAura Signs & Prints — Portal source package

This repository is a **development foundation**, not a deployed or fully functional ordering website.

## Included

- `index.html`: legacy UI prototype rebranded for AdAura. It still contains Claude-specific authentication, database and storage calls, so it is not a standalone production application.
- `supabase/migrations/`: database schema and pricing migration files.
- `src/pricing.js`: pure B2B/B2C pricing calculation helpers. GST rate must be passed explicitly for each product/variant.
- `src/printing.test.js`: automated pricing tests.
- `docs/PRICING_POLICY.md`: agreed prototype pricing assumptions.
- `backend_plan.md`: backend implementation notes.
- `phase1_status.md`: project status notes.

## Pricing assumptions

- Supplier catalogue rates are treated as GST-inclusive.
- B2C: 100% markup on supplier cost before GST, then add the applicable GST rate.
- B2B: add the greater of 20% of supplier-inclusive rate or ₹50 (initial agreed rule).
- The earlier blanket 18% assumption is a planning assumption only. Product GST classification/rates must be verified before issuing tax invoices.

## Run pricing tests

Requires Node.js 18+.

```bash
npm install
npm run test:pricing
```

## Backend and launch status

The project owner previously reported successfully running both Supabase SQL migrations and seeing the expected tables in the Supabase Table Editor. The live project state has not been independently inspected through a Supabase connection in this session.

The following work is still outstanding or needs verification before launch:

- Replace legacy Claude-specific frontend calls with Supabase Auth, database, Storage and Edge Function calls.
- Verify Supabase Auth, Storage, Row Level Security and server-side order/pricing functions.
- Import and verify the approved product catalogue, variants and supplier costs.
- Add the selected silver-and-gold logo asset.
- Complete customer registration, cart, order submission and admin workflows.
- Implement and test wallet and Razorpay payment flows.
- Configure deployment, domain, GST invoice rules, refunds and audit logging.
- Complete security and end-to-end testing.

**Do not use the current prototype to accept live customer orders or payments.** Never commit Supabase service-role keys, database passwords, or payment gateway secrets.
