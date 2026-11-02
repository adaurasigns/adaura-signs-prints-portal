# AdAura Signs & Prints — standalone portal

This branch is a clean replacement for the Supabase-dependent implementation. It uses a Node.js/Express application and a local SQLite database. **Supabase is not required anywhere in the runtime.**

## Run locally

Requirements: Node.js 22+ and npm.

```bash
npm install
cp .env.example .env
```

Set the environment variables in `.env`, then:

```bash
npm start
```

Open:
- Customer portal: http://localhost:3000
- Admin dashboard: http://localhost:3000/admin.html
- Health check: http://localhost:3000/api/health

The first administrator is created on first startup only when `ADMIN_EMAIL` and `ADMIN_PASSWORD` are set. Use a long unique password. The server will not silently create a public default admin account.

## Environment

See `.env.example`. In production:
- Set `NODE_ENV=production`.
- Set `SESSION_SECRET` to a random secret of at least 32 characters.
- Set `ADMIN_EMAIL` and `ADMIN_PASSWORD` for the initial admin bootstrap; remove the password from deployment configuration after the account has been created.
- Set `DATA_DIR` to a persistent disk path. SQLite database and artwork uploads are stored there.
- Use HTTPS and a single app instance with a persistent local disk. SQLite is intentionally selected for a simple single-server deployment; do not run multiple app replicas sharing a network filesystem.

## Current functionality

- Customer registration and password sign-in.
- B2B/B2C customer types and admin approval.
- Product and variant catalogue, with supplier costs stored server-side.
- Server-calculated customer prices.
- Enquiry basket submission and customer enquiry history.
- Artwork upload to private local storage.
- Admin dashboard for customer approval, product/variant creation, pricing settings, enquiry status and enquiry-to-order conversion.
- Order status management and manual payment-status recording.

## Important limitations

This is a working foundation, not yet a production commerce platform:
- Email verification, password reset and transactional email are not implemented.
- Session storage currently uses Express's in-memory store; configure a persistent session store before production deployment.
- No payment gateway integration, automatic payment verification, GST invoice generation, refunds or wallet ledger.
- Artwork upload is limited to 25 MB and a MIME-type allowlist; add malware scanning and stronger file validation before accepting public uploads.
- The catalogue database starts empty. Products and variants must be entered through the admin dashboard or imported using a reviewed SQLite import.
- GST defaults to 18% as a prototype value. Confirm product-wise tax classifications with your CA before issuing invoices.
- Pricing uses the agreed prototype rules: B2C markup on pre-GST supplier cost; B2B markup/minimum addition. Confirm commercial rules and rounding before production.

## Database and backups

The database is `DATA_DIR/adaura.sqlite`; uploaded files are in `DATA_DIR/uploads`. Back up both together, and test restoration. Never commit the data directory, credentials, database files or uploaded customer artwork.

## Deployment recommendation

Use one small VPS or a managed Node host that provides persistent disk storage. Build and test locally first, then deploy behind HTTPS. Do not use a static-only host for this application: it needs a running Node server and persistent writable storage.
