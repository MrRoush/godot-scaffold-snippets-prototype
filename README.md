# Godot Scaffold Snippets Prototype

Prototype Godot 4.7 addon for beginner-friendly, scaffolded GDScript authoring in classrooms.

## Purpose
This repository explores a hybrid instructional approach:
- Guided snippet insertion in **real GDScript**
- Progressive scaffold fading (Level 1 -> Level 2)
- Friendly, student-readable error explanations
- Beginner genre packs (Platformer + Top-Down)

## Quick Start
1. Open this project in Godot 4.7+
2. Enable the addon:
   - Project -> Project Settings -> Plugins
   - Enable `Scaffold Snippets`
3. Open `scenes/demo_classroom.tscn`
4. Click the **Scaffold Snippets** dock in the editor

## Current Prototype Scope
- Editor dock UI skeleton
- Snippet pack definitions (JSON)
- Script insertion stubs
- Friendly error mapping table
- Curriculum-aligned docs for continuity and future Copilot sessions

## Repo Structure
- `addons/scaffold_snippets/` addon code and plugin config
- `snippets/` snippet packs used by the addon
- `docs/` goals, architecture, memory/history, and roadmap
- `scenes/` simple demo scene

## Notes
This is intentionally lightweight and instructional-first; not production-ready yet.
