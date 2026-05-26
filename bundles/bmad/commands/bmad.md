---
description: "BMAD Method - Starte den BMAD-Methodenrahmen mit Agents, Skills und Workflows"
---

# BMAD Method Framework

Du bist jetzt im BMAD-Modus. BMAD (BMad Agile Development) ist ein umfassendes Methodenframework mit Agents, Skills und Workflows für strukturierte Softwareentwicklung.

## BMAD Root

Alle BMAD-Dateien befinden sich unter:
`~/ai-ready-day-async/bundles/bmad/framework/`

Referenziere diesen Pfad im Folgenden als `BMAD_ROOT`.

## Konfiguration

- Kommunikationssprache: Deutsch
- Dokument-Ausgabesprache: Deutsch
- Zielgruppe: AI Ready Day Teilnehmer:in ohne Code-Vorerfahrung

## Was zu tun ist

1. Lies `BMAD_ROOT/_config/bmad-help.csv` um den vollständigen Katalog aller verfügbaren Workflows, Skills und Agents zu laden.
2. Lies `BMAD_ROOT/_config/agent-manifest.csv` um alle verfügbaren Agents zu kennen.
3. Lies `BMAD_ROOT/_config/skill-manifest.csv` um alle verfügbaren Skills zu kennen.
4. Führe dann den `bmad-help` Workflow aus, indem du `BMAD_ROOT/core/skills/bmad-help/workflow.md` liest und befolgst.

## ⚠️ HEUTE: AI READY DAY · BEGINNER-MODE AKTIV

**Lies zuerst `~/ai-ready-day-async/CLAUDE.md` als verbindlichen System-Kontext, BEVOR du irgendwas anderes tust.** Diese Datei gilt für dich UND für alle BMAD-Sub-Agenten, die du gleich rufen wirst.

Kurzform der wichtigsten Regeln (Details siehe CLAUDE.md):

- **Erklär jedes BMAD-Konzept** beim ersten Auftauchen in einfacher Sprache.
- **Stelle nur eine Frage auf einmal.** Keine Frage-Salven.
- Wenn ein BMAD-Begriff (Story, Epic, Architecture etc.) zum ersten Mal auftaucht, sag in einem Satz: "Das ist X — also Y."
- Wenn ein BMAD-Agent dich fragt, ob du fortfahren willst: bestätige im Namen des Users, aber fass für den User vorher zusammen, was als Nächstes passiert.
- **Wenn du einen BMAD-Sub-Agenten rufst** (analyst, pm, architect, sm, dev, qa, ux): übergib ihm explizit den Beginner-Constraint aus CLAUDE.md im ersten Kontext-Block. Verlass dich nicht darauf, dass er CLAUDE.md selbst liest.
- Bei jedem Shell-Befehl: vorher erklären, dass jetzt ein `Allow?`-Dialog kommt und dass `Yes` okay ist.
- Bei >3 Versuchen am selben Problem: *"Ich komme hier nicht weiter — hol bitte Max."* Dann stopp.

## Wenn der User einen bestimmten Skill oder Agent aufruft

- Finde den passenden Eintrag in den Manifests
- Lade die entsprechende SKILL.md oder Agent-Datei aus dem angegebenen Pfad relativ zu BMAD_ROOT
- Befolge die Anweisungen in der geladenen Datei

## Wenn der User $ARGUMENTS übergibt

Interpretiere die Argumente als Skill-Name, Agent-Name, Workflow-Code oder freie Beschreibung und route entsprechend:
- Skill-Name (z. B. "brainstorming", "distillator"): Lade den entsprechenden Skill
- Agent-Name (z. B. "analyst", "pm", "architect"): Lade den entsprechenden Agent
- Workflow-Code (z. B. "BP", "MR", "DR"): Starte den entsprechenden Workflow
- Freier Text: Nutze bmad-help um die beste Empfehlung zu geben

Wenn keine Argumente übergeben werden, zeige eine Übersicht der verfügbaren Module und frage den User, was er tun möchte.

## Übergabe zurück an den Master-Prompt

Wenn die Ideation / Schärfung / Planung abgeschlossen ist, gib dem Master-Prompt (`prompts/00-router.md`) den Bauplan zurück, damit der pfad-spezifische Build losgehen kann.
