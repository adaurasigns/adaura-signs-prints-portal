[CmdletBinding()]
param(
  [string]$AppName = "adaura-portal"
)
$ErrorActionPreference = "Stop"

function Invoke-WeenyCli {
  param([Parameter(ValueFromRemainingArguments=$true)][string[]]$Arguments)
  & npx.cmd --yes weeny-cloud @Arguments
  if ($LASTEXITCODE -ne 0) { throw "Weeny CLI failed (exit code $LASTEXITCODE)." }
}

Write-Host ""
Write-Host "AdAura Signs & Prints - Weeny free beta deployment" -ForegroundColor Cyan
Write-Host "This route deploys directly on your existing Weeny server; it avoids the Windows upload/push protocol."
Write-Host ""

try {
  $node = (node --version 2>$null)
  if (-not $node) { throw "Node.js 22 or later is required. Install it from https://nodejs.org/en/download/ and reopen PowerShell." }
  $major = [int](($node.TrimStart('v')).Split('.')[0])
  if ($major -lt 22) { throw "Found Node.js $node. Upgrade to Node.js 22 or later." }
  Write-Host "Using $node"

  Write-Host ""
  Write-Host "Signing in to Weeny. Enter the email used for your Weeny account."
  Invoke-WeenyCli login

  Write-Host ""
  Write-Host "Checking your Weeny server list. If one exists, we will reuse it."
  Invoke-WeenyCli

  $hasServer = Read-Host "Does the listing above show a server for your account? Enter Y or N"
  if ($hasServer.Trim().ToUpperInvariant() -ne "Y") {
    throw "No running Weeny server was confirmed. Return to your Weeny dashboard and wait for server provisioning; do not create another server from this script."
  }

  Write-Host ""
  Write-Host "Checking server-side Git and Weeny deploy support..."
  Invoke-WeenyCli ssh "command -v git >/dev/null 2>&1 || (apt-get update && apt-get install -y git); git --version; command -v weeny; weeny help deploy"

  Write-Host ""
  Write-Host "Fetching AdAura source onto the server and deploying from there."
  $deployCommand = "mkdir -p /workspace && if [ -d /workspace/adaura-portal/.git ]; then git -C /workspace/adaura-portal fetch origin work/no-supabase-rebuild && git -C /workspace/adaura-portal checkout -B work/no-supabase-rebuild FETCH_HEAD; else git clone --depth 1 --branch work/no-supabase-rebuild https://github.com/adaurasigns/adaura-signs-prints-portal.git /workspace/adaura-portal; fi && cd /workspace/adaura-portal && weeny deploy $AppName --from /workspace/adaura-portal --build 'npm install --omit=dev' -- npm run start:weeny"
  Invoke-WeenyCli ssh $deployCommand

  $adminEmail = Read-Host "Enter the email address you will use for the AdAura administrator login"
  if ([string]::IsNullOrWhiteSpace($adminEmail) -or $adminEmail -match "\s") {
    throw "Enter a valid administrator email address."
  }

  $bytes = New-Object byte[] 48
  $rng = [Security.Cryptography.RandomNumberGenerator]::Create()
  try { $rng.GetBytes($bytes) } finally { $rng.Dispose() }
  $sessionSecret = ([BitConverter]::ToString($bytes)).Replace("-", "").ToLowerInvariant()

  $passBytes = New-Object byte[] 24
  $rng2 = [Security.Cryptography.RandomNumberGenerator]::Create()
  try { $rng2.GetBytes($passBytes) } finally { $rng2.Dispose() }
  $adminPassword = ([BitConverter]::ToString($passBytes)).Replace("-", "").ToLowerInvariant()
  $emailB64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($adminEmail))

  Write-Host ""
  Write-Host "Setting a persistent session secret and bootstrapping your first admin account..."
  $envCommand = "weeny env $AppName NODE_ENV=production SESSION_SECRET=$sessionSecret ADMIN_NAME='AdAura Administrator' ADMIN_EMAIL=`$(printf '%s' '$emailB64' | base64 -d) ADMIN_PASSWORD=$adminPassword"
  Invoke-WeenyCli ssh $envCommand

  Write-Host ""
  Write-Host "Publishing the customer portal over HTTPS..."
  Invoke-WeenyCli ssh "weeny expose $AppName 3000"

  Write-Host ""
  Write-Host "DEPLOYMENT COMMANDS COMPLETED." -ForegroundColor Green
  Write-Host "Open the HTTPS URL printed above and check /api/health, / and /admin.html."
  Write-Host ""
  Write-Host "Your first AdAura admin password (save it in a password manager):"
  Write-Host $adminPassword -ForegroundColor Yellow
  Write-Host "This password is not saved by this script. Do not share it or paste it into ChatGPT."
  Write-Host ""
  Write-Host "The free server sleeps after 30 minutes without traffic; the first request after sleep may take longer."
}
catch {
  Write-Host ""
  Write-Host ("STOPPED: " + $_.Exception.Message) -ForegroundColor Red
  Write-Host "No password or login code should be posted in this chat."
  exit 1
}
