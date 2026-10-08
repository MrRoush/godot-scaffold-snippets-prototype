# Architecture Overview (Prototype)

## Components
- `plugin.gd` registers an Editor dock and initializes services.
- `scaffold_dock.gd/.tscn` provides teacher/student-facing controls.
- `SnippetLibrary` loads JSON packs from `res://snippets/`.
- `SnippetInserter` renders scaffold level and fills placeholders.
- `FriendlyErrorMapper` converts raw errors into What/Why/Fix.

## Data-Driven Snippets
Snippets are JSON dictionaries with:
- `id`
- `title`
- `code` (real GDScript with `{{placeholders}}`)
- `comments` (used for scaffold fade)

## Scaffolding Levels
- Level 1: Full snippet + comments/hints.
- Level 2: Reduced hints (comments stripped where possible).

## Why this architecture
- Lightweight and easy to extend.
- Curriculum-friendly (new snippets as content packs).
- Preserves transfer to authentic GDScript.
