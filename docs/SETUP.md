# Setup für die Async-Variante des AI Ready Day · Schritt für Schritt

> Diese Anleitung ist für dich, wenn du noch nie programmiert hast.
> Wir erklären alles. Wenn ein Wort neu ist — kein Stress, einfach weitermachen.

## Was du schon hast (gut!)

- ✅ Mac
- ✅ Claude Pro-Account (über falkemedia)
- ✅ Claude Desktop App
- ✅ Falkemedia-Google-Account

## Was wir heute zusätzlich brauchen

- **GitHub** — wie Google Drive, aber für Code
- **Vercel** — bringt deine App ins Internet (falls du Web-App baust)
- **Supabase** — Datenbank, falls deine App eine braucht
- **Claude Code** — das CLI-Tool, mit dem wir heute bauen

---

## 0. ⚠️ ZUERST: Theorie überfliegen (20-30 Min)

Bevor du das Terminal überhaupt aufmachst:

📖 **`docs/theorie/ai-crashkurs.pdf`** öffnen und durchgehen.

Du musst nicht alles auswendig können. Wichtig ist vor allem:
- Was ist KI / LLM / Workflow / Agent (Folien 3-11)
- Was ist Vibe-Coding (Folie 12)
- BMAD-Team (Folie 18)
- **Folie 20 (Idea-Check) — die brauchen wir gleich!**

---

## 1. GitHub-Account (3 Min)

GitHub ist wie Google Drive für Code. Wir brauchen einen Account, weil Vercel und Supabase darüber funktionieren.

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

## 3. Supabase-Account (2 Min, nur wenn du Web-App mit Datenbank planst)

Supabase ist eine Datenbank — also der Ort, wo deine App ihre Infos speichert. Kostenlos für unsere Zwecke.

- Geh auf https://supabase.com
- Klick **"Start your project"** → **"Sign in with GitHub"**
- **Free**-Plan auswählen
- Fertig — Projekte legen wir später per Befehl an

## 4. Terminal öffnen (nur für das einmalige Setup)

Das Terminal ist ein Fenster, in dem du dem Computer Befehle in Textform gibst. **Heute brauchst du es nur einmal, fürs Setup.** Danach arbeitest du in der gewohnten Claude Desktop App weiter.

- Drück `Cmd + Leertaste`
- Tipp `Terminal`
- Drück Enter

Du siehst jetzt ein Fenster, in dem dein Benutzername steht. Genau richtig.

## 5. Bootstrap ausführen

Kopier diesen Befehl ins Terminal, drück Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/mkleinsorg-creator/ai-ready-day-async/main/bootstrap.sh -o ~/bootstrap.sh && bash ~/bootstrap.sh
```

Das Script erklärt unterwegs, was es macht. Lies mit — das hilft beim Verstehen.

**⚠️ Wichtige Momente im Script — bitte vorher lesen:**

1. **Mac-Passwort-Abfrage** (passiert in den ersten Sekunden):
   - Du wirst nach deinem **Mac-Login-Passwort** gefragt (das, mit dem du dich morgens am Mac einloggst).
   - 👉 **Das Passwort wird beim Tippen NICHT angezeigt** — keine Sterne, keine Punkte, einfach nichts. Das ist Absicht (Sicherheits-Feature von macOS).
   - Tipp einfach blind dein Passwort und drück Enter. Auch wenn das Terminal aussieht, als würde nichts passieren — es funktioniert.

2. **GitHub-Login** (etwa nach 2-3 Min):
   - Browser öffnet sich von selbst, du loggst dich mit deinem GitHub-Account ein, autorisierst — fertig.
   - Nach diesem einen Login bleibt deine Authentifizierung gespeichert, du musst das nicht nochmal machen.

Falls das Script dich noch an anderer Stelle zum Einloggen auffordert: gleiches Prinzip — Browser geht auf, anmelden, fertig.

## 6. Rüber in die Claude Desktop App — der erste echte Schritt heißt BMAD

Wenn das Script `✅ Fertig` sagt: **Terminal kannst du jetzt liegenlassen.**

- Öffne die **Claude Desktop App** (kennst du schon — das ist die, in der du sonst chattest)
- Drück **`Cmd + 3`** — das öffnet das integrierte Claude-Code-Fenster innerhalb der App. Dort funktionieren Slash-Commands wie `/bmad`.
- In die erste Nachricht eintippen oder reinkopieren (genau so):

```
Lies @~/ai-ready-day-async/prompts/00-router.md vollständig und folge diesen Anweisungen als Master-Prompt.
```

Claude begrüßt dich und führt dich dann durch:
1. **Selbst-Check** — hast du die Theorie überflogen?
2. **Begrüßung + Richtung** — Web-App oder n8n?
3. **Idea-Check** — die 6 Fragen aus Folie 20 (gemeinsam, einzeln, mit Erklärung)
4. **BMAD-Übergabe** — das Sieben-Agenten-Team übernimmt
5. **Bauen, in deinem Tempo**

Ab hier: einfach machen lassen. Du bist in guten Händen.

## Wann brauchst du das Terminal nochmal?

Nur, wenn Claude dir sagt *"Kopier diesen Befehl ins Terminal"* — z. B. wenn deine Web-App lokal gestartet oder ins Internet gestellt werden soll. Dann holst du das Terminal-Fenster kurz nach vorne, drückst Enter, und gehst zurück in die Claude Desktop App.

---

## Tempo-Empfehlung

Drei Sessions à 90 Minuten:
- **Session 1:** Setup (Schritte 0-6) + Phase 1-3 mit Claude (Selbst-Check, Idee, Idea-Check)
- **Session 2:** BMAD-Ideation + Architecture
- **Session 3:** Build + Deploy + Tagesernte

Aber: macht keinen Druck. Wenn ihr eine Stunde frustriert seid — Pause, Kaffee, nochmal ran.

---

## Wenn etwas hakt

Schau in `docs/TROUBLESHOOTING.md` oder DM an Max (@max.kleinsorg) auf Slack.
Das ist keine Schwäche — das ist Plan.
