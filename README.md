# AI Ready Day · Async-Variante

> Für drei Kolleginnen, die am AI Ready Day nicht teilnehmen konnten — und ihn jetzt in ihrem eigenen Tempo nachholen.

Du baust hier mit Claude und BMAD entweder eine **eigene Web-App** oder einen **n8n-Workflow**. Asynchron, in deinem Tempo. Du brauchst keine Programmier-Erfahrung — alles wird Schritt für Schritt erklärt.

## Bevor du startest — bitte unbedingt:

📖 **`docs/theorie/ai-crashkurs.pdf`** überfliegen (20-30 Minuten)

Vor allem **Folie 20** ("Sechs Fragen. Ein Workflow, der läuft.") brauchst du gleich. Ohne diese 20-30 Minuten Vorlauf machst du dir den Rest unnötig schwer.

---

## Start in 3 Schritten

### 1. Terminal öffnen (nur für das einmalige Setup)

Drück `Cmd + Leertaste`, tipp `Terminal`, drück Enter.
Ein schwarzes Fenster geht auf. **Hier passiert nur das Setup** — danach arbeitest du komplett in der Claude Desktop App.

### 2. Diese beiden Befehle einzeln reinkopieren und Enter drücken

```bash
curl -fsSL https://raw.githubusercontent.com/mkleinsorg-creator/ai-ready-day-async/main/bootstrap.sh -o ~/bootstrap.sh
```

```bash
bash ~/bootstrap.sh
```

Das Script richtet dir alles ein und erklärt dabei, was es tut.
Dauert ca. 5-8 Minuten. Wenn etwas hakt: Max via Slack-DM (@max.kleinsorg).

### 3. In die Claude Desktop App wechseln

- **Öffne die Claude Desktop App** (die du eh schon hast)
- Drück **`Cmd + 3`** — das öffnet das integrierte Claude-Code-Fenster
- In die erste Nachricht eintippen oder reinkopieren:

```
Lies @~/ai-ready-day-async/prompts/00-router.md vollständig und folge diesen Anweisungen als Master-Prompt.
```

**Was als nächstes passiert:**
1. Claude fragt, ob du die Theorie-Slides überflogen hast (Selbst-Check)
2. Claude fragt nach deinem Namen + deiner Idee
3. **Idea-Check** — die 6 Fragen aus Folie 20 gehen wir gemeinsam durch
4. Übergabe an **BMAD** — ein Team aus sieben Spezialisten, das mit dir baut
5. Schritt für Schritt zur fertigen Web-App oder zum laufenden n8n-Workflow

---

## Was ist hier drin?

| Ordner / Datei | Was es ist |
|---|---|
| `docs/theorie/ai-crashkurs.pdf` | **Pflicht-Reading** — Theorie-Slides vom Tag |
| `docs/SETUP.md` | Falls du Schritt für Schritt willst |
| `docs/TROUBLESHOOTING.md` | Wenn etwas hakt |
| `bootstrap.sh` | Setup-Script — macht alles startklar |
| `prompts/00-router.md` | Der Master-Prompt, der dich führt |
| `prompts/10-webapp.md` | Tech-Briefing für die Web-App-Variante |
| `prompts/20-n8n.md` | Tech-Briefing für die n8n-Variante |
| `bundles/bmad/` | BMAD-Framework + 7 Spezialisten-Agenten |
| `bundles/n8n/` | 8 n8n-Spezialisten-Agenten |

## Tempo — mach's in DEINEM Rhythmus

Empfohlen: **drei Sessions à 90 Minuten**.

- **Session 1:** Setup + Theorie + Idea-Check (komplett asynchron mit Claude)
- **Session 2:** BMAD-Ideation + Architecture
- **Session 3:** Build + Deploy

Aber: keine Deadline. Wenn du eine Stunde frustriert bist — Pause machen, Kaffee, und nochmal ran. Das ist normal.

## Wenn etwas hakt

**Erste Adresse:** `docs/TROUBLESHOOTING.md`

Wenn das nicht hilft:
- Akute Blocker → Slack-DM an @max.kleinsorg
- Allgemeine Fragen → Slack-Channel (Max teilt dir den richtigen)

---

*Made with 💚 für die falkemedia Gruppe · Async-Variante des AI Ready Day · Mai 2026*
