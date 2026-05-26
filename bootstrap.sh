#!/bin/bash
set -e

REPO_URL="https://github.com/mkleinsorg-creator/ai-ready-day-async.git"
TARGET_DIR="$HOME/ai-ready-day-async"

say() { echo ""; echo "👉 $1"; echo ""; }
ok()  { echo "   ✅ $1"; }

echo ""
echo "════════════════════════════════════════════════"
echo "  AI Ready Day · Async-Variante · Setup"
echo "════════════════════════════════════════════════"
echo ""
sleep 1

say "Hi! Ich richte dir jetzt alles ein. Dauert ca. 5 Minuten."
say "Lies einfach mit — ich erkläre dir unterwegs, was passiert."
sleep 1

# Pre-check: TTY für interaktive Passwort-Eingaben (Homebrew braucht das)
if [ ! -t 0 ]; then
  echo ""
  echo "⚠️  STOPP: Dieses Script läuft ohne TTY — Homebrew kann dich dann nicht"
  echo "    nach deinem Mac-Passwort fragen."
  echo ""
  echo "    Bitte führ es stattdessen so aus (kopier den ganzen Block):"
  echo ""
  echo "    curl -fsSL https://raw.githubusercontent.com/mkleinsorg-creator/ai-ready-day-async/main/bootstrap.sh -o ~/bootstrap.sh && bash ~/bootstrap.sh"
  echo ""
  exit 1
fi

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  say "Schritt 1/10 · Ich installiere Homebrew (Paketmanager für Mac)."
  echo ""
  echo "    ⚠️  WICHTIG · Bitte lies das hier kurz:"
  echo ""
  echo "    Du wirst gleich nach deinem MAC-LOGIN-PASSWORT gefragt"
  echo "    (das, mit dem du dich morgens am Mac einloggst)."
  echo ""
  echo "    👉 Das Passwort wird beim Tippen NICHT angezeigt — keine"
  echo "       Sterne, keine Punkte, einfach nichts. Das ist normal."
  echo "       Tipp einfach blind dein Passwort und drück Enter."
  echo ""
  sleep 4
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -d /opt/homebrew ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  say "Schritt 1/10 · Homebrew"
  ok "schon installiert"
fi

# 2. Node.js
if ! command -v node >/dev/null 2>&1 || [ "$(node -v 2>/dev/null | cut -d. -f1 | tr -d 'v')" -lt 20 ]; then
  say "Schritt 2/10 · Ich installiere Node.js (das brauchen alle Tools heute)."
  brew install node
else
  say "Schritt 2/10 · Node.js"
  ok "schon installiert ($(node -v))"
fi

# 3. Git
if ! command -v git >/dev/null 2>&1; then
  say "Schritt 3/10 · Ich installiere Git."
  brew install git
else
  say "Schritt 3/10 · Git"
  ok "schon installiert"
fi

# 4. GitHub CLI + Auth-Login
if ! command -v gh >/dev/null 2>&1; then
  say "Schritt 4/10 · Ich installiere die GitHub-CLI (damit du später ohne Passwort-Eingabe pushen kannst)."
  brew install gh
else
  say "Schritt 4/10 · GitHub CLI"
  ok "schon installiert"
fi

# Auth-Status prüfen, ggf. Login starten
if ! gh auth status >/dev/null 2>&1; then
  say "Du loggst dich gleich bei GitHub ein — Browser geht von selbst auf."
  echo "    Wähl: 'GitHub.com' → 'HTTPS' → 'Login with a web browser'."
  echo "    Code im Terminal kopieren, im Browser einfügen, autorisieren."
  echo ""
  gh auth login -h github.com -p https -w || say "GitHub-Login übersprungen — du kannst das später mit 'gh auth login' nachholen."
else
  ok "Bei GitHub bereits eingeloggt"
fi

# 5. Repo klonen
say "Schritt 5/10 · Ich lade das AI-Ready-Day-Repo runter."
if [ -d "$TARGET_DIR/.git" ]; then
  cd "$TARGET_DIR" && git pull
  ok "Repo ist aktuell"
else
  rm -rf "$TARGET_DIR" 2>/dev/null || true
  git clone "$REPO_URL" "$TARGET_DIR"
  ok "Repo nach $TARGET_DIR geklont"
fi
cd "$TARGET_DIR"

# 6. Claude Code
if ! command -v claude >/dev/null 2>&1; then
  say "Schritt 6/10 · Ich installiere Claude Code — unser Hauptwerkzeug."
  npm install -g @anthropic-ai/claude-code
else
  say "Schritt 6/10 · Claude Code"
  ok "schon installiert"
fi

# 7. Vercel CLI
if ! command -v vercel >/dev/null 2>&1; then
  say "Schritt 7/10 · Ich installiere die Vercel-CLI (um Apps ins Internet zu bringen)."
  npm install -g vercel
else
  say "Schritt 7/10 · Vercel CLI"
  ok "schon installiert"
fi

# 8. Supabase CLI
if ! command -v supabase >/dev/null 2>&1; then
  say "Schritt 8/10 · Ich installiere die Supabase-CLI (für Datenbanken)."
  brew install supabase/tap/supabase
else
  say "Schritt 8/10 · Supabase CLI"
  ok "schon installiert"
fi

# 9. BMAD + n8n Agents/Commands installieren
say "Schritt 9/10 · Ich lege die BMAD-Methode und die n8n-Spezialisten in deinem Claude-Verzeichnis ab."
mkdir -p "$HOME/.claude/agents" "$HOME/.claude/commands"

# BMAD-Agents
cp -f "$TARGET_DIR/bundles/bmad/agents/"*.md "$HOME/.claude/agents/" 2>/dev/null || true
ok "7 BMAD-Agenten installiert"

# n8n-Agents
cp -f "$TARGET_DIR/bundles/n8n/agents/"*.md "$HOME/.claude/agents/" 2>/dev/null || true
ok "8 n8n-Agenten installiert"

# BMAD-Slash-Command (angepasst — verweist auf Repo-Pfad)
cp -f "$TARGET_DIR/bundles/bmad/commands/bmad.md" "$HOME/.claude/commands/bmad.md"
ok "/bmad Slash-Command verfügbar"

# 10. MCP-Konfiguration
say "Schritt 10/10 · Ich richte die MCP-Verbindungen ein (Filesystem + Asana)."
mkdir -p "$HOME/.claude"
sed "s|<DEIN_USER>|$USER|g" "$TARGET_DIR/.mcp.json.template" > "$HOME/.claude/.mcp.json"
ok ".mcp.json geschrieben"

echo ""
echo "════════════════════════════════════════════════"
echo "  ✅ Fertig! Du bist startklar."
echo "════════════════════════════════════════════════"
echo ""
echo "  Was du JETZT machst:"
echo ""
echo "    1. Dieses Terminal liegen lassen — wir brauchen es vielleicht später."
echo ""
echo "    2. Öffne die Claude Desktop App (die du sonst auch nutzt)."
echo ""
echo "    3. Drück Cmd + 3 — das öffnet das integrierte"
echo "       Claude-Code-Fenster innerhalb der App."
echo ""
echo "    4. In die erste Nachricht eintippen oder reinkopieren:"
echo ""
echo "         Lies @~/ai-ready-day-async/prompts/00-router.md vollständig"
echo "         und folge diesen Anweisungen als Master-Prompt."
echo ""
echo "  Ab da führt dich Claude durch BMAD und den Rest des Tages."
echo ""
echo "════════════════════════════════════════════════"
echo ""
