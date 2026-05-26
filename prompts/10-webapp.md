# Tech-Briefing für BMAD · Pfad: Web-App

> Diese Datei ist **kein User-Prompt**, sondern ein **Pflicht-Kontext für BMAD**.
> Der Master-Prompt übergibt diesen Inhalt beim Start von `/bmad` an die BMAD-Agenten.
> BMAD-Architect und BMAD-Dev richten ihre Empfehlungen nach diesem Briefing.

## Tech-Stack (verbindlich für diesen Tag)

| Layer | Tool | Warum |
|---|---|---|
| Frontend-Framework | **Next.js** (App-Router) | Standard im Haus, sofort deploybar |
| Hosting | **Vercel** | Ein-Befehl-Deploy, GitHub-Integration |
| Datenbank (falls nötig) | **Supabase** | Free-Tier, schnelles Setup |
| Styling | **TailwindCSS** | Schnell, vorhersagbar, von Next-CLI default |
| Versionierung | **Git + GitHub** | Standard, im Bootstrap installiert |

## Was BMAD-Architect berücksichtigen muss

- **Keep it small:** Eine Story zuerst zum Laufen bringen. Dann erweitern.
- **Deploy früh:** Nach Story 1 schon einmal `vercel deploy` — das erste Live-Erlebnis ist wichtiger als Polish.
- **Datenbank nur, wenn echt nötig:** Bei reinen Frontend-Apps (Landingpage, Mockup, statisches Tool) Supabase weglassen. Komplexität raus.
- **Keine Auth in der ersten Iteration:** Anonyme Demo zuerst. Auth ist eine Story 2-3-Sache, niemals Story 1.

## Was BMAD-Dev berücksichtigen muss

- **Erklär jeden Befehl, bevor du ihn ausführst.** User hat keine Code-Erfahrung.
- **Bash-Tool-Berechtigungen:** Vor jedem Shell-Befehl fragt Claude Code um Erlaubnis. Bereite den User darauf vor: *"Du wirst jetzt 'Allow' geklickt, das ist okay."*
- **Pfade:** Projekte landen in `~/ai-ready-day-async/projects/<projektname>/`
- **npm-Defaults annehmen:** Bei `create-next-app`-Fragen alle Defaults durchklicken, keine User-Interaktion verlangen
- **Lokaler Server vor Deploy:** `npm run dev` zeigt das Ergebnis auf `localhost:3000` — Aha-Moment. Erst danach Deploy.
- **Vercel-Login beim ersten Deploy:** Browser-OAuth, User loggt sich mit GitHub ein. Einmaliger Schritt.

## Was BMAD-QA berücksichtigen muss

- **Smoke-Test reicht:** *"Lädt die Seite? Klickt der Button? Speichert die DB?"* — keine vollständige Test-Suite.
- **Manuell testen lassen:** User soll selbst im Browser klicken und Feedback geben.
- **Bei Fehlern:** Fehlermeldung vorlesen, auf Deutsch übersetzen, Fix vorschlagen.

## falkemedia-spezifische Constraints

- **Keine echten Kunden-Daten** in heute gebauten Test-Apps. Wir spielen mit Dummy-Daten.
- **GitHub-Repos** unter User's persönlichem Account, nicht falkemedia-Org (kein Org-Admin-Zugriff im Workshop).
- **Vercel-Hobby-Plan:** ausreichend für heute, kein Pro-Upgrade nötig.

## Erfolgs-Definition für diesen Pfad

Am Ende des Tages hat der User:
1. Eine funktionierende App **lokal laufen** (`localhost:3000`)
2. **Live im Internet deployt** (Vercel-URL, die er teilen kann)
3. Mindestens **eine Iteration** durchlaufen (erste Version → Feedback → zweite Version)

Wenn nur 1 + 2 erreicht werden: völlig okay. Wenn 3 dazukommt: brilliant.
