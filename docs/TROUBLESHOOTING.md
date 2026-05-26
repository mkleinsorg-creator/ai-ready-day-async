# Troubleshooting · Wenn was hakt

> Erste Regel: Wenn du 10 Minuten irgendwo festhängst — Slack-DM an @max.kleinsorg.
> Das hier ist kein Quiz, kein Test, keine Prüfung.

## Allgemein

### "Ich verstehe nicht, was Claude gerade tut"

Frag Claude direkt im Chat: *"Erklär mir das nochmal in einfachen Worten."*
Claude ist genau dafür da. Es gibt keine dummen Fragen.

### "Claude macht etwas, das ich nicht wollte"

Tipp `Ctrl + C` (das stoppt Claude) und sag ihm:
*"Stopp. Lass uns nochmal anfangen — ich wollte eigentlich X."*

---

## Setup-Probleme

### "Ich kann beim Passwort nichts tippen"

Doch, du kannst — du siehst es nur nicht. **macOS zeigt Passwörter beim Tippen NIE an** (keine Sterne, keine Punkte, einfach nichts). Das ist ein Sicherheits-Feature, kein Bug.

Tipp einfach blind dein normales **Mac-Login-Passwort** (das, mit dem du dich morgens einloggst) und drück Enter. Auch wenn das Terminal aussieht, als würde nichts passieren — es funktioniert.

### "3 incorrect password attempts"

macOS hat dein Passwort dreimal nicht akzeptiert. Häufige Gründe:
- Du hast das falsche Passwort eingegeben (z. B. Apple-ID-Passwort statt Mac-Login-Passwort)
- Die Caps-Lock-Taste war an
- Du hast aus Versehen das alte Passwort eingegeben, falls du es kürzlich geändert hast

Lösung: Bootstrap nochmal starten und es nochmal probieren. Falls auch dann nicht: Max rufen.


### `command not found: claude`

Wahrscheinlich ist Node.js nicht richtig im PATH. Lösung:

```bash
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Dann nochmal versuchen. Wenn's immer noch nicht klappt: Max.

### `EACCES: permission denied`

Du sollst **nie** `sudo npm install` machen. Wenn dir das jemand vorschlägt, sag nein. Stattdessen:

```bash
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Dann Bootstrap nochmal ausführen.

### `git: command not found`

Mac hat Git eigentlich vorinstalliert. Wenn nicht:

```bash
xcode-select --install
```

Das öffnet ein Apple-Fenster. Bestätigen, warten, fertig.

### Homebrew-Installation hängt

Wenn `brew install` bei "Updating Homebrew..." hängt, einfach `Ctrl + C` drücken und nochmal versuchen. Manchmal Netzwerkproblem.

### Bootstrap bricht in der Mitte ab

Kein Drama. Lauf ihn einfach nochmal — das Script ist so gebaut, dass es zweimal hintereinander laufen darf, ohne kaputtzugehen.

```bash
curl -fsSL https://raw.githubusercontent.com/mkleinsorg-creator/ai-ready-day-async/main/bootstrap.sh -o ~/bootstrap.sh
bash ~/bootstrap.sh
```

---

## Claude Code-Probleme

### "Claude Code Login öffnet den Browser nicht"

URL aus dem Terminal kopieren und manuell im Browser einfügen.

### "MCP-Server lädt nicht"

Schließ Claude Code (`Ctrl + C`), starte es neu. Falls das nicht klappt:

```bash
cat ~/.claude/.mcp.json
```

Wenn die Datei leer oder kaputt aussieht: Max rufen.

### "Asana sagt 'unauthorized'"

Du musst dich beim ersten Asana-Aufruf einmalig autorisieren. Claude Code öffnet dafür den Browser. Wenn das nicht passiert ist: in Claude eingeben:

```
/mcp asana reconnect
```

---

## Pfad-spezifische Probleme

### Web-App: `npm error code ENOENT`

Du bist wahrscheinlich nicht im richtigen Ordner. Check:

```bash
pwd
```

Du solltest in `~/ai-ready-day-async/projects/<dein-projekt>` sein.

### n8n: "Workflow lässt sich nicht importieren"

Die JSON-Datei muss valide sein. Lass Claude sie überprüfen:
*"Validier bitte die workflow.json und sag mir, wo der Fehler ist."*

---

## Async-spezifisch

### "Ich bin festgefahren, aber Max ist nicht erreichbar"

Erste Schritte, in dieser Reihenfolge:

1. **Pause machen** — 15 Min weg vom Bildschirm. Häufig löst sich das Problem im Kopf, nicht im Code.
2. **Claude fragen** — *"Ich bin seit X Minuten an [Problem] hängengeblieben. Erklär mir nochmal in ganz einfachen Worten, was passieren soll und was die letzten Fehlermeldungen genau heißen."*
3. **Slack-DM an Max** — mit konkretem Fehlertext, Screenshot wenn möglich, und kurzer Beschreibung was du gemacht hast bevor's hakte.
4. **Nicht aufgeben** — der Fehler ist meistens trivial, du siehst ihn nur gerade nicht.

### "Ich habe eine Session unterbrochen — wie komme ich zurück rein?"

Im Claude-Code-Fenster die nächste Nachricht einfach mit dem Master-Prompt-Befehl starten:

```
Lies @~/ai-ready-day-async/prompts/00-router.md vollständig und folge diesen Anweisungen als Master-Prompt. Ich war schon mal hier — bitte lies vorher die session-stand.md in meinem Projekt-Ordner.
```

Falls der Stand verloren ging: erzähl Claude einfach kurz auf Deutsch, wo du standest. Es wird sich anpassen.

---

## Last Resort

**Slack-DM an @max.kleinsorg.** Mit Fehlertext + Screenshot wenn möglich. Das ist keine Schwäche — das ist Plan.
