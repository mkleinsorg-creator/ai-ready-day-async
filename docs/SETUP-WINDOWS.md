# Setup für die Async-Variante des AI Ready Day · Windows · Schritt für Schritt

> Diese Anleitung ist für dich, wenn du auf einem **Windows-PC** arbeitest und noch nie programmiert hast.
> Wir erklären alles. Wenn ein Wort neu ist — kein Stress, einfach weitermachen.

## Was du schon hast (gut!)

- ✅ Windows-PC (Windows 10 oder 11)
- ✅ Claude Pro-Account (über falkemedia)
- ✅ Claude Desktop App
- ✅ Falkemedia-Google-Account

## Was wir heute zusätzlich brauchen

- **GitHub** — wie Google Drive, aber für Code
- **Vercel** — bringt deine App ins Internet (falls du Web-App baust)
- **Claude Code (CLI)** — das Werkzeug, mit dem wir heute bauen

---

## 0. ⚠️ ZUERST: Theorie überfliegen (20-30 Min)

Bevor du PowerShell überhaupt aufmachst:

📖 **`docs/theorie/ai-crashkurs.pdf`** öffnen und durchgehen — liegt im Repo:
https://github.com/mkleinsorg-creator/ai-ready-day-async/blob/main/docs/theorie/ai-crashkurs.pdf

Wichtig: Schau dir vor allem **Folie 20** an (Idea-Check). Die 6 Fragen darauf gehen wir mit Claude zusammen durch.

---

## 1. GitHub-Account (3 Min)

GitHub ist wie Google Drive für Code. Wir brauchen einen Account, weil Vercel & Co. darüber funktionieren.

- Geh auf https://github.com
- Klick oben rechts auf **"Sign up"**
- Nimm deine **falkemedia-Mail**
- Username egal — kann auch lustig sein
- E-Mail bestätigen

## 2. Vercel-Account (2 Min, nur wenn du Web-App planst)

Vercel macht aus deinem Code eine echte Webseite im Internet. Kostenlos für unsere Zwecke.

- Geh auf https://vercel.com/signup
- Klick **"Continue with GitHub"** → Autorisieren
- **"Hobby"**-Plan auswählen
- Fertig

## 3. PowerShell öffnen (nur für das einmalige Setup)

PowerShell ist ein Fenster, in dem du dem PC Befehle in Textform gibst. **Heute brauchst du es nur einmal, fürs Setup.** Danach arbeitest du in der gewohnten Claude Desktop App weiter.

- Drück die **Windows-Taste**
- Tipp `PowerShell`
- Drück Enter

Du siehst jetzt ein blaues oder schwarzes Fenster. Genau richtig.

> 💡 **Wichtig:** Es gibt mehrere Terminals auf Windows (cmd, PowerShell, Windows Terminal). Du brauchst **PowerShell** — das blaue. Das andere (`cmd`, schwarz mit `C:\>`) funktioniert NICHT für unser Script.

## 4. Bootstrap ausführen

Kopier diese **zwei Befehle** ins PowerShell-Fenster, jeweils mit Enter:

```powershell
irm https://raw.githubusercontent.com/mkleinsorg-creator/ai-ready-day-async/main/bootstrap.ps1 -OutFile $env:TEMP\bootstrap.ps1
```

```powershell
powershell -ExecutionPolicy Bypass -File $env:TEMP\bootstrap.ps1
```

Das Script erklärt unterwegs, was es macht. Lies mit — das hilft beim Verstehen.

**⚠️ Wichtige Momente im Script:**

1. **winget-Sicherheitsabfrage** (mehrfach):
   - Wenn Windows fragt *„App-Quelle akzeptieren?"* → mit `Y` bestätigen.
   - Passiert pro Tool-Install einmal.

2. **GitHub-Login** (etwa nach 2 Min):
   - Browser öffnet sich, du loggst dich mit GitHub-Account ein, autorisierst.
   - Code aus PowerShell kopieren, im Browser einfügen.

3. **Windows SmartScreen / Defender-Warnung**:
   - Wenn Windows fragt, ob du den Befehl wirklich ausführen willst → bestätigen.
   - Das Script ist Open Source und liegt auf GitHub — du kannst es vorher anschauen.

## 5. Rüber in die Claude Desktop App — der erste echte Schritt heißt BMAD

Wenn das Script `[OK] Fertig` sagt: **PowerShell kannst du jetzt liegenlassen.**

- Öffne die **Claude Desktop App** (kennst du schon — das ist die, in der du sonst chattest)
- Drück **`Ctrl + 3`** — das öffnet das integrierte Claude-Code-Fenster innerhalb der App. Dort funktionieren Slash-Commands wie `/bmad`.
  - *Falls `Ctrl + 3` nicht klappt: frag Max via Slack-DM — das Tastenkürzel kann unter Windows leicht abweichen.*
- In die erste Nachricht eintippen oder reinkopieren (genau so):

```
Lies @C:\Users\<DEIN_USERNAME>\ai-ready-day-async\prompts\00-router.md vollständig und folge diesen Anweisungen als Master-Prompt.
```

> Ersetz `<DEIN_USERNAME>` durch deinen Windows-Benutzernamen — der steht oben im PowerShell-Fenster nach `C:\Users\`.

Claude begrüßt dich und führt dich dann durch:
1. **Selbst-Check** — hast du die Theorie überflogen?
2. **Begrüßung + Richtung** — Web-App oder n8n?
3. **Idea-Check** — die 6 Fragen aus Folie 20 (gemeinsam, einzeln, mit Erklärung)
4. **BMAD-Übergabe** — das Sieben-Agenten-Team übernimmt
5. **Bauen, in deinem Tempo**

## Wann brauchst du PowerShell nochmal?

Nur, wenn Claude dir sagt *„Kopier diesen Befehl in PowerShell"* — z. B. wenn deine Web-App lokal gestartet oder ins Internet gestellt werden soll.

---

## Tempo-Empfehlung

Drei Sessions à 90 Minuten:
- **Session 1:** Setup (Schritte 0-5) + Phase 1-3 mit Claude
- **Session 2:** BMAD-Ideation + Architecture
- **Session 3:** Build + Deploy + Tagesernte

Aber: macht keinen Druck. Wenn du eine Stunde frustriert bist — Pause, Kaffee, nochmal ran.

---

## Wenn etwas hakt

Schau in `docs/TROUBLESHOOTING.md` oder schick Max eine Slack-DM (@max.kleinsorg).
Das ist keine Schwäche — das ist Plan.

## Wichtigste Windows-Unterschiede zur Mac-Anleitung

| Mac | Windows |
|---|---|
| Terminal (Cmd + Leertaste) | PowerShell (Windows-Taste) |
| Homebrew als Paket-Manager | winget als Paket-Manager |
| `~/ai-ready-day-async` | `C:\Users\<DEIN_USERNAME>\ai-ready-day-async` |
| `Cmd + 3` für Claude-Code-Fenster | `Ctrl + 3` (vermutlich) |
| `bash` | `PowerShell` |
