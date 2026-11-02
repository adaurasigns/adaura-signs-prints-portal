# AdAura portal — deployment notes

## Current customer portal foundation

The static storefront is in `index.html`. It uses Supabase Auth in the browser and calls the authenticated `catalogue` Edge Function for customer-specific prices. The browser must only receive the Supabase public anon/publishable key. Never put the service-role key in `index.html`.

## Supabase setup

The project owner previously reported applying the two initial migrations and seeing the schema tables. Confirm the live project before applying anything again. Apply the new migration `202611020003_enquiries_and_supplier_cost_protection.sql` after the first two migrations. It removes direct customer access to supplier-rate rows and creates the secure enquiry table.

### 1. Import the visiting-card catalogue

Review `supabase/seeds/visiting_cards_printers_club.sql`, then run it once in the Supabase SQL Editor for the AdAura project. It imports 17 product groups and 118 variants from the supplied Printers Club visiting-card rate list. Supplier prices are stored GST-inclusive; pack sizes from the source are retained.

The seed uses an 18% GST field to match the existing prototype migration. This is not a legal classification of every product. Confirm each product's applicable GST treatment with the CA before issuing tax invoices.

### 2. Deploy the catalogue Edge Function

From the repository root, with the Supabase CLI linked to the AdAura project:

```sh
supabase link --project-ref cnlfupchndmkoaqhkrxz
supabase functions deploy catalogue\nsupabase functions deploy submit-enquiry
```

Both functions use Supabase's Edge Function environment variables and require JWT verification. `catalogue` verifies the signed-in user, checks account approval, calculates customer-specific B2B/B2C prices on the server, and never returns supplier cost. `submit-enquiry` revalidates variant IDs, quantities and prices on the server before saving the customer's enquiry.

### 3. Connect the browser

Open the deployed site and use **Configure connection** to enter:
- Project URL: `https://cnlfupchndmkoaqhkrxz.supabase.co`
- Supabase public anon/publishable key from Project Settings → API Keys.

Do not paste the service-role key. The public key is intended for browser use and relies on RLS plus server-side functions for protection.

## Not yet live

The enquiry builder submits a saved quote enquiry after migration 003 and both Edge Functions are deployed. It does not create a production order, accept artwork, debit wallet funds or charge Razorpay. Those require separate transactional Edge Functions, payment/webhook verification, admin bootstrap and end-to-end testing. Do not accept live payments until those pieces are complete.
