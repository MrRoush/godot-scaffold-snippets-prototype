# Continuity Memory for Future Copilot Sessions

This document preserves project intent, decisions, and next actions so future Copilot interactions maintain continuity.

## Origin Summary
Project started as a classroom prototype for struggling coders in a Godot 4.7 game development course.

## Non-Negotiable Design Principles
1. Keep memory footprint small.
2. Prioritize readability and accessibility.
3. Translate errors into plain language.
4. Keep output aligned with real GDScript.

## Chosen Direction
Snippet-driven scaffolded GDScript prototype with beginner game packs and scaffold fading.

## Included Prototype Features (v0.1.0)
- Editor dock: list snippets, choose scaffold level, preview inserted code.
- Platformer snippets: movement + jump.
- Top-down snippets: movement + chase.
- Friendly error explanation panel.
- Foundational docs and roadmap.

## Pending / Next Tasks
1. Insert directly into selected script file (not just preview).
2. Read placeholders from UI fields per snippet (instead of hardcoded defaults).
3. Add Input Map validator and one-click setup helper.
4. Add bilingual glossary mode and optional read-aloud support.
5. Add lesson-aligned sample scenes with scripts attached.
6. Add teacher analytics: common errors encountered.

## How to Resume Work Quickly
When opening a new Copilot chat, reference:
- `docs/copilot_continuity_memory.md`
- `docs/goals_and_vision.md`
- `docs/architecture.md`

Suggested prompt:
"Continue implementing the roadmap in docs/roadmap.md for Godot 4.7, starting with direct script insertion and placeholder UI fields."
