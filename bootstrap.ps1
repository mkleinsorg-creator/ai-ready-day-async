# AI Ready Day - Setup fuer Windows (PowerShell)
# Ausfuehren mit:
#   irm https://raw.githubusercontent.com/mkleinsorg-creator/ai-ready-day-async/main/bootstrap.ps1 -OutFile $env:TEMP\bootstrap.ps1
#   powershell -ExecutionPolicy Bypass -File $env:TEMP\bootstrap.ps1

$ErrorActionPreference = "Continue"
$REPO_URL  = "https://github.com/mkleinsorg-creator/ai-ready-day-async.git"
$TARGET_DIR = Join-Path $env:USERPROFILE "ai-ready-day-async"

function Say { param($msg) Write-Host ""; Write-Host ">>> $msg" -ForegroundColor Cyan; Write-Host "" }
function Ok  { param($msg) Write-Host "   [OK] $msg" -ForegroundColor Green }
function Err { param($msg) Write-Host "   [X]  $msg" -ForegroundColor Red }

function Refresh-Path {
    $machine = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')
    $user    = [System.Environment]::GetEnvironmentVariable('Path', 'User')
    $env:Path = $machine + ';' + $user
}

Write-Host ""
Write-Host "================================================" -ForegroundColor White
Write-Host "  AI Ready Day - Setup fuer deinen Windows-PC" -ForegroundColor White
Write-Host "================================================" -ForegroundColor White
Write-Host ""
Start-Sleep -Seconds 1

Say "Hi! Ich richte dir jetzt alles ein. Dauert ca. 5-8 Minuten."
Say "Lies einfach mit - ich erklaere dir unterwegs, was passiert."
Start-Sleep -Seconds 1

# Pruefen: winget verfuegbar?
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Err "winget (Windows Package Manager) ist nicht installiert."
    Write-Host "    Bitte den Microsoft Store oeffnen und 'App Installer' aktualisieren," -ForegroundColor Yellow
    Write-Host "    dann den Bootstrap erneut starten. Oder Max ansprechen." -ForegroundColor Yellow
    exit 1
}

# 1. Node.js
Say "Schritt 1/8 - Node.js"
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "    Ich installiere Node.js via winget..."
    winget install -e --id OpenJS.NodeJS --silent --accept-source-agreements --accept-package-agreements
    Refresh-Path
} else {
    Ok "schon installiert ($(node -v))"
}

# 2. Git
Say "Schritt 2/8 - Git"
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "    Ich installiere Git via winget..."
    winget install -e --id Git.Git --silent --accept-source-agreements --accept-package-agreements
    Refresh-Path
} else {
    Ok "schon installiert"
}

# 3. GitHub CLI + Auth-Login
Say "Schritt 3/8 - GitHub CLI"
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "    Ich installiere die GitHub-CLI via winget (damit du spaeter ohne Passwort-Eingabe pushen kannst)..."
    winget install -e --id GitHub.cli --silent --accept-source-agreements --accept-package-agreements
    Refresh-Path
} else {
    Ok "schon installiert"
}

# Auth-Status pruefen
$ghStatus = & gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Say "Du loggst dich gleich bei GitHub ein - Browser geht von selbst auf."
    Write-Host "    Waehle: 'GitHub.com' -> 'HTTPS' -> 'Login with a web browser'." -ForegroundColor Yellow
    Write-Host "    Code im Terminal kopieren, im Browser einfuegen, autorisieren." -ForegroundColor Yellow
    Write-Host ""
    & gh auth login -h github.com -p https -w
    if ($LASTEXITCODE -ne 0) {
        Say "GitHub-Login uebersprungen - du kannst das spaeter mit 'gh auth login' nachholen."
    }
} else {
    Ok "Bei GitHub bereits eingeloggt"
}

# 4. Repo klonen
Say "Schritt 4/8 - Ich lade das AI-Ready-Day-Repo runter."
if (Test-Path (Join-Path $TARGET_DIR ".git")) {
    Push-Location $TARGET_DIR
    & git pull
    Pop-Location
    Ok "Repo ist aktuell"
} else {
    if (Test-Path $TARGET_DIR) { Remove-Item -Recurse -Force $TARGET_DIR }
    & git clone $REPO_URL $TARGET_DIR
    Ok "Repo nach $TARGET_DIR geklont"
}

# 5. Claude Code
Say "Schritt 5/8 - Claude Code"
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host "    Ich installiere Claude Code via npm..."
    npm install -g "@anthropic-ai/claude-code"
} else {
    Ok "schon installiert"
}

# 6. Vercel CLI
Say "Schritt 6/8 - Vercel CLI"
if (-not (Get-Command vercel -ErrorAction SilentlyContinue)) {
    Write-Host "    Ich installiere die Vercel-CLI (um Apps ins Internet zu bringen)..."
    npm install -g vercel
} else {
    Ok "schon installiert"
}

# 7. BMAD + n8n Agents/Commands installieren
Say "Schritt 7/8 - Ich lege die BMAD-Methode und die n8n-Spezialisten in deinem Claude-Verzeichnis ab."
$claudeDir   = Join-Path $env:USERPROFILE ".claude"
$agentsDir   = Join-Path $claudeDir "agents"
$commandsDir = Join-Path $claudeDir "commands"
New-Item -ItemType Directory -Force -Path $agentsDir, $commandsDir | Out-Null

Copy-Item -Path (Join-Path $TARGET_DIR "bundles\bmad\agents\*.md") -Destination $agentsDir -Force
Ok "7 BMAD-Agenten installiert"

Copy-Item -Path (Join-Path $TARGET_DIR "bundles\n8n\agents\*.md") -Destination $agentsDir -Force
Ok "8 n8n-Agenten installiert"

Copy-Item -Path (Join-Path $TARGET_DIR "bundles\bmad\commands\bmad.md") -Destination $commandsDir -Force
Ok "/bmad Slash-Command verfuegbar"

# 8. MCP-Konfiguration
Say "Schritt 8/8 - Ich richte die MCP-Verbindungen ein (Filesystem + Asana)."
$mcpTemplate = Join-Path $TARGET_DIR ".mcp.json.template"
$mcpTarget   = Join-Path $claudeDir ".mcp.json"
$userPath    = ($env:USERPROFILE -replace '\\','/') + "/ai-ready-day-async"
(Get-Content $mcpTemplate) -replace '<DEIN_USER>', $env:USERNAME -replace '/Users/[^/]+/ai-ready-day-async', $userPath | Set-Content $mcpTarget
Ok ".mcp.json geschrieben"

Write-Host ""
Write-Host "================================================" -ForegroundColor White
Write-Host "  [OK] Fertig! Du bist startklar." -ForegroundColor Green
Write-Host "================================================" -ForegroundColor White
Write-Host ""
Write-Host "  Was du JETZT machst:" -ForegroundColor White
Write-Host ""
Write-Host "    1. Dieses PowerShell-Fenster liegen lassen - wir brauchen es vielleicht spaeter." -ForegroundColor White
Write-Host ""
Write-Host "    2. Oeffne die Claude Desktop App (die du sonst auch nutzt)." -ForegroundColor White
Write-Host ""
Write-Host "    3. Druecke Ctrl + 3 - das oeffnet das integrierte" -ForegroundColor White
Write-Host "       Claude-Code-Fenster innerhalb der App." -ForegroundColor White
Write-Host "       (Falls Ctrl + 3 nicht klappt, frag Max - das Tastenkuerzel" -ForegroundColor White
Write-Host "        kann unter Windows leicht abweichen.)" -ForegroundColor White
Write-Host ""
Write-Host "    4. In die erste Nachricht eintippen oder reinkopieren:" -ForegroundColor White
Write-Host ""
Write-Host "         Lies @$TARGET_DIR\prompts\00-router.md vollstaendig" -ForegroundColor Cyan
Write-Host "         und folge diesen Anweisungen als Master-Prompt." -ForegroundColor Cyan
Write-Host ""
Write-Host "  Ab da fuehrt dich Claude durch BMAD und den Rest des Tages." -ForegroundColor White
Write-Host ""
Write-Host "================================================" -ForegroundColor White
Write-Host ""
