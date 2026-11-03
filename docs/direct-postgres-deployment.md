# Apply AdAura database migration without the Supabase Dashboard

This route uses PostgreSQL directly. It does not require Google sign-in or the Supabase web dashboard.

## Before running

You need the database connection string (or host, database, user, port and database password) for project `cnlfupchndmkoaqhkrxz`. Do not commit it, paste it into chat, or put it in a source file.

The live project was previously reported to have migrations 001 and 002 applied manually. Screenshots confirmed the core tables and the `gst_rate_percent` column, but the migration tracking table was absent. This procedure assumes those first two schema changes really are present. The script below only runs migration 003; it does not replay 001 or 002.

## Windows PowerShell with psql

1. Install PostgreSQL command-line tools (psql) if not already installed.
2. In PowerShell, set the connection string for this terminal session only:

```powershell
$env:PGSSLMODE = "require"
$env:PGCONNECT_TIMEOUT = "15"
```

For security and compatibility, the preferred method is to let psql prompt for the password rather than setting PGPASSWORD. Use the connection URI with the password omitted:

```powershell
psql "host=YOUR_DB_HOST port=5432 dbname=postgres user=postgres sslmode=require" -W -v ON_ERROR_STOP=1 -f "supabase/migrations/202611020003_enquiries_and_supplier_cost_protection.sql"
```

Replace only YOUR_DB_HOST with the database host shown in the connection details you already have. psql will prompt for the password without echoing it.

3. Verify the result with:

```sql
SELECT policyname, cmd, roles
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename = 'product_variants'
ORDER BY policyname;

SELECT to_regclass('public.enquiries') AS enquiries_table;
```

Expected: `read active variants` is absent, `admins manage variants` remains, and `public.enquiries` exists.

## Important safeguards

- Do not use the Supabase service-role key as a PostgreSQL password.
- Do not use the browser anon/publishable key as a database password.
- Do not share a database password or full connection URI in chat or GitHub.
- Do not run migrations 001 or 002 again.
- Do not run the visiting-card seed until the migration and policy verification succeed.
- If the database password is unavailable, stop. Resetting it generally requires project-owner access; do not guess passwords or keep retrying.
- The SQL migration is idempotent for the policy drop and enquiries table creation, but review the exact live policy name before execution if it differs from the screenshot.
