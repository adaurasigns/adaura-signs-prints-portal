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
Write-Host "This script downloads the prepared app, signs into Weeny, deploys it, and prints the beta URL."
Write-Host ""

try {
  $node = (node --version 2>$null)
  if (-not $node) {
    throw "Node.js 22 or later is required. Install it from https://nodejs.org/en/download/ and reopen PowerShell."
  }
  $major = [int](($node.TrimStart('v')).Split('.')[0])
  if ($major -lt 22) { throw "Found Node.js $node. Upgrade to Node.js 22 or later from https://nodejs.org/en/download/." }
  Write-Host "Using $node"

  $root = Join-Path $env:USERPROFILE "AdAura-Weeny"
  $zip = Join-Path $env:TEMP "adaura-no-supabase.zip"
  $extract = Join-Path $env:TEMP "adaura-no-supabase-source"
  $source = Join-Path $extract "adaura-signs-prints-portal-work-no-supabase-rebuild"

  if (Test-Path $extract) { Remove-Item -Recurse -Force $extract }
  New-Item -ItemType Directory -Force -Path $extract | Out-Null
  $archiveUrl = "https://github.com/adaurasigns/adaura-signs-prints-portal/archive/refs/heads/work/no-supabase-rebuild.zip"
  Write-Host "Downloading the approved AdAura source from GitHub..."
  Invoke-WebRequest -Uri $archiveUrl -OutFile $zip
  Expand-Archive -Path $zip -DestinationPath $extract -Force
  if (-not (Test-Path (Join-Path $source "package.json"))) { throw "Downloaded source archive did not contain the expected project." }

  Write-Host ""
  Write-Host "Signing in to Weeny. Enter the email used for your Weeny account."
  Invoke-WeenyCli login

  Write-Host ""
  Write-Host "Checking your Weeny server list. If one exists, we will reuse it."
  Invoke-WeenyCli

  $hasServer = Read-Host "Does the listing above show a server for your account? Enter Y or N"
  if ($hasServer.Trim().ToUpperInvariant() -ne "Y") {
    Write-Host "Creating your Weeny server. This starts the initial seven-day full-size period."
    Invoke-WeenyCli create
  } else {
    Write-Host "Reusing your existing Weeny server."
  }

  Write-Host ""
  Write-Host "Deploying AdAura. The build imports the 17 product groups and 118 variants."
  Invoke-WeenyCli push $source $AppName --build "npm install --omit=dev" -- "npm run start:weeny"

  $adminEmail = Read-Host "Enter the email address you will use for the AdAura admin login"
  if ([string]::IsNullOrWhiteSpace($adminEmail)) { throw "An admin email is required to create the first administrator account." }

  $bytes = New-Object byte[] 32
  $rng = [Security.Cryptography.RandomNumberGenerator]::Create()
  try { $rng.GetBytes($bytes) } finally { $rng.Dispose() }
  $sessionSecret = ([BitConverter]::ToString($bytes)).Replace("-", "").ToLowerInvariant()

  $passBytes = New-Object byte[] 24
  $rng2 = [Security.Cryptography.RandomNumberGenerator]::Create()
  try { $rng2.GetBytes($passBytes) } finally { $rng2.Dispose() }
  $adminPassword = ([BitConverter]::ToString($passBytes)).Replace("-", "").ToLowerInvariant()

  Write-Host "Setting production session security and creating your first admin account..."
  Invoke-WeenyCli ssh "weeny env $AppName NODE_ENV=production SESSION_SECRET=$sessionSecret ADMIN_NAME=AdAura ADMIN_EMAIL=$adminEmail ADMIN_PASSWORD=$adminPassword"

  Write-Host ""
  Write-Host "Making the customer portal public over HTTPS..."
  Invoke-WeenyCli ssh "weeny expose $AppName 3000"

  Write-Host ""
  Write-Host "DEPLOYMENT COMMANDS COMPLETED." -ForegroundColor Green
  Write-Host "Open the HTTPS URL printed above and check /api/health, / and /admin.html."
  Write-Host ""
  Write-Host "Your first AdAura admin password is shown below. Save it in a password manager now:"
  Write-Host $adminPassword -ForegroundColor Yellow
  Write-Host "This password is not saved by this script. Do not send it to anyone or paste it into ChatGPT."
  Write-Host ""
  Write-Host "The free server sleeps after 30 minutes of inactivity. First requests after sleep may take a little longer."
  Write-Host "If any command failed, copy only the error text here. Do not share login codes, passwords, or tokens."
}
catch {
  Write-Host ""
  Write-Host ("STOPPED: " + $_.Exception.Message) -ForegroundColor Red
  Write-Host "No password or login code should be posted in this chat."
  exit 1
}
