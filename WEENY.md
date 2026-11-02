# AdAura beta on Weeny Cloud (no card)

Weeny offers a free persistent Linux server with a shareable HTTPS URL and no card requirement. The free tier is 1 vCPU / 1 GB RAM, sleeps after 30 minutes without traffic, and wakes on the next request. The first seven-day larger-server trial starts when the server is provisioned, then moves to the free tier. Free public apps show a small Weeny badge. Custom domains and always-on operation are paid features. Capacity for free servers/trials is limited. Check current details at https://weeny.cloud/free and https://weeny.cloud/pricing.

## Important before using it

Use this first deployment for a private/controlled beta with test customer accounts and test artwork. The portal is not yet a complete production commerce platform. It has no payment gateway, GST invoice automation, email verification/password reset, or malware scanning. Keep independent exports of data. Weeny states that its off-machine backups run periodically (roughly every three hours), so recent writes can fall outside the last snapshot.

## App details

- Name: `adaura-portal`
- Runtime: Node.js 22+
- Start command: `npm run start:weeny` (runs the initial idempotent catalogue import, then `npm start`)
- Port: `3000`
- Health endpoint: `/api/health`
- Data directory: use the injected `WEENY_DATA_DIR` environment variable. The server and seed importer already prefer this variable automatically.
- The application stores the SQLite database, login sessions and uploaded artwork below that persistent directory.

## Quick deployment on Windows 10/11

The repository includes a guided PowerShell script that uses the existing server-side deploy command. This avoids the laptop upload/push protocol; it clones the public source from GitHub on the Weeny server, deploys from `/workspace/adaura-portal`, sets a persistent session secret and first administrator, and exposes port 3000 over HTTPS.

Requirements: Node.js 22+ and PowerShell. Git for Windows and Windows OpenSSH may be installed for the laptop CLI. Open a fresh PowerShell window and ensure Git Bash is on PATH for this session if the CLI reports a process-spawn error. Then run:

```powershell
$env:Path = "$env:LOCALAPPDATA\Programs\Git\bin;$env:LOCALAPPDATA\Programs\Git\usr\bin;$env:Path"
$script = Join-Path $env:TEMP 'deploy-adaura-weeny.ps1'
Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/adaurasigns/adaura-signs-prints-portal/work/no-supabase-rebuild/deploy-weeny.ps1' -OutFile $script
powershell -ExecutionPolicy Bypass -File $script
```

Follow the prompts. The script asks for the Weeny account email and verification code, checks for the existing server, deploys on that server, and asks for the AdAura admin email. It generates a unique administrator password locally and prints it once at the end. Save it in a password manager. Never paste the password or email verification code into ChatGPT. If a command fails, share only the error text.
## Deployment from a machine with the repository checked out

Weeny's CLI runs on your computer. It deploys the current local folder; merely connecting GitHub is not enough.

1. Create a Weeny account at https://weeny.cloud/free using an email address you can access. Login uses an emailed one-time code. No card is required according to the current free-plan page.
2. Install Node.js 22+ on the computer and open a terminal in the checked-out repository folder.
3. Sign in and check for an existing server before creating another:

```bash
npx weeny-cloud login
npx weeny-cloud
```

4. Only if no server exists, create one. This begins the seven-day full-size trial; after that it moves to the free 1 GB server unless you explicitly choose a paid plan:

```bash
npx weeny-cloud create
```

5. Deploy this application. This repository currently has no package-lock.json, so use `npm install`, not `npm ci`. Install dependencies and import the supplier catalogue in the release build. The Weeny startup command runs an idempotent importer for the 17 product groups / 118 variants. Existing SKUs are left untouched on later starts so admin rate edits are preserved.

```bash
npx weeny-cloud push . adaura-portal --build "npm install --omit=dev" -- npm run start:weeny
```

6. Expose the app on port 3000 and keep the returned HTTPS URL:

```bash
npx weeny-cloud ssh "weeny expose adaura-portal 3000"
```

7. Open the HTTPS URL. Check `/api/health`, `/` and `/admin.html`. The first request after a long idle period may take time because the free server sleeps.

## Configure the first admin account

Before inviting anyone, set the initial admin credentials using Weeny's encrypted environment-variable command. Generate a unique password locally; do not paste it into a chat or commit it to GitHub.

```bash
npx weeny-cloud ssh "weeny env adaura-portal ADMIN_NAME='AdAura Administrator' ADMIN_EMAIL='YOUR_ADMIN_EMAIL'"
```

Set the password in a second command so shell quoting remains easy; replace the placeholder with a strong unique password locally:

```bash
npx weeny-cloud ssh "weeny env adaura-portal ADMIN_PASSWORD='REPLACE_WITH_A_LONG_UNIQUE_PASSWORD'"
```

Weeny's environment command restarts the app. The admin account is created on the first start when both variables are present. Once you can sign in at `/admin.html`, remove ADMIN_EMAIL and ADMIN_PASSWORD from the environment to prevent repeated bootstrap configuration; the saved admin account remains in SQLite. The environment values are encrypted by Weeny according to its docs.

Do not send the password or email verification code to ChatGPT. Enter them only in your own terminal/dashboard.

## Updates and diagnostics

After the first push, Weeny remembers the deploy and start commands:

```bash
npx weeny-cloud push . adaura-portal
npx weeny-cloud ssh "weeny inspect adaura-portal"
npx weeny-cloud ssh "weeny deployments adaura-portal"
```

For logs, use the Weeny dashboard or:

```bash
npx weeny-cloud ssh "journalctl -u weeny-adaura-portal -n 100 --no-pager"
```

## Data and recovery

The app's database and artwork live in `$WEENY_DATA_DIR` and survive app releases. Weeny says off-machine snapshots are periodic, not continuous. Keep separate periodic exports of the SQLite database and uploads, and test restoration before treating the portal as a production system.

## Notes

- The free machine shares 1 vCPU / 1 GB RAM among all apps; large builds may fail. The app has no front-end build step, but npm installs native SQLite dependencies. If the first release build runs out of memory, build dependencies on a local Node 22 environment with a matching Linux architecture or use a larger plan only after reviewing the cost.
- The free server sleeps after 30 idle minutes, so it is suitable for a trial/beta, not a guaranteed always-on service.
- The default public URL is a Weeny subdomain. Custom domains require a paid plan.
- Do not collect actual customer payment information on this beta. Customer records and uploaded artwork are personal/business data; keep the test limited until additional security and operational review.
