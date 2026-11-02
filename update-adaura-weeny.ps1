$ErrorActionPreference = "Stop"

# Add Git Bash to this PowerShell session's PATH. Needed by the Weeny CLI
# on some Windows installations; no global Windows settings are changed.
$env:Path = "$env:LOCALAPPDATA\Programs\Git\bin;$env:LOCALAPPDATA\Programs\Git\usr\bin;$env:Path"

Write-Host "Updating AdAura from the latest GitHub branch on your existing Weeny server..." -ForegroundColor Cyan
$remoteCommand = "git -C /workspace/adaura-portal fetch origin work/no-supabase-rebuild && git -C /workspace/adaura-portal checkout -B work/no-supabase-rebuild FETCH_HEAD && cd /workspace/adaura-portal && weeny deploy adaura-portal --from /workspace/adaura-portal --build 'npm install --omit=dev' -- npm run start:weeny"
& npx.cmd --yes weeny-cloud ssh $remoteCommand
if ($LASTEXITCODE -ne 0) {
  throw "The server-side update did not complete. Keep the existing live release; it should remain serving. Share only the error text, never login codes or passwords."
}
Write-Host ""
Write-Host "Weeny deploy command completed. The existing HTTPS address should remain the same." -ForegroundColor Green
Write-Host "Check https://adaura-portal-00dv.onweeny.com and /api/health."
