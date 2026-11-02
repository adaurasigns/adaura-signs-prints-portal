# AdAura portal — deployment notes

## Current customer portal foundation

The static storefront is in `index.html`. It uses Supabase Auth in the browser and calls the authenticated `catalogue` Edge Function for customer-specific prices. The browser must only receive the Supabase public anon/publishable key. Never put the service-role key in `index.html`.

## Supabase setup

The project owner previously reported applying the two initial migrations and seeing the schema tables. The live database has not yet been independently inspected through an authenticated database session. Confirm the live project before applying anything again.

Apply `202611020003_enquiries_and_supplier_cost_protection.sql` only after verifying that the first two schema migrations are already represented in the live database. Do not blindly replay the first two migrations.

### 1. Import the visiting-card catalogue

Review `supabase/seeds/visiting_cards_printers_club.sql`, then run it once in the Supabase SQL Editor for the AdAura project. It imports 17 product groups and 118 variants from the supplied Printers Club visiting-card rate list. Supplier prices are stored GST-inclusive; pack sizes from the source are retained.

The seed uses an 18% GST field to match the existing prototype migration. This is not a legal classification of every product. Confirm each product's applicable GST treatment with the CA before issuing tax invoices.

### 2. Deploy the Edge Functions

Install the Supabase CLI and authenticate it using an authorised Supabase access token. From the repository root:

```powershell
supabase link --project-ref cnlfupchndmkoaqhkrxz
supabase functions deploy catalogue
supabase functions deploy submit-enquiry
```

Both functions require JWT verification. `catalogue` verifies the signed-in user, checks account approval, calculates customer-specific B2B/B2C prices on the server, and never returns supplier cost. `submit-enquiry` revalidates variant IDs, quantities and prices on the server before saving the customer's enquiry.

### 3. Connect the browser

Open the deployed site and use **Configure connection** to enter:
- Project URL: `https://cnlfupchndmkoaqhkrxz.supabase.co`
- Supabase public anon/publishable key from Project Settings → API Keys.

Do not paste the service-role key. The public key is intended for browser use and relies on RLS plus server-side functions for protection.

## Access and secret handling

- A Google sign-in session is not the same thing as the PostgreSQL database password.
- A Supabase access token or database password must be obtained through an authorised project-owner account or Supabase's account-recovery/support process.
- Never commit access tokens, database passwords, anon keys, or service-role keys to this repository.
- Do not send secrets in chat. Add deployment secrets only to the appropriate protected GitHub/Supabase secret store.
- The assistant has not accessed the live database or deployed these functions; the repository contains the prepared code only.

## Not yet production-ready

The enquiry builder is intended to save a quote enquiry after migration 003 and both Edge Functions are deployed. It does not create a production order, accept artwork, debit wallet funds or charge Razorpay. Those require separate transactional Edge Functions, payment/webhook verification, admin bootstrap and end-to-end testing.

Before accepting live orders or payments:
1. Verify migration 003 and the supplier-cost access policy in the live database.
2. Deploy both Edge Functions and test them with customer and admin accounts.
3. Create and verify a secure first-admin bootstrap process.
4. Confirm product GST classifications and pricing rules with the CA/business owner.
5. Complete order, artwork, payment, webhook, invoice and refund workflows.
6. Test customer isolation, duplicate submissions, invalid quantities and unauthorised access.

Do not accept live payments until those pieces are complete.
