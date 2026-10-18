# Immersive Namelists Expanded - Addon: Larger Selector - Agent Rules

Shared rules for every mod in this tree (file encodings, build commands, engine knowledge, git) are in the Modding Manager's `../../GEMINI.md`; Claude Code loads it by itself, Antigravity reads it first.

## What this mod is
- A quality-of-life UI addon that enlarges the division namelist dropdown of the Division Designer (`countrydivisiondesignerview`). It changes only `interface/`, outside the checksum, so Ironman, achievements and multiplayer stay compatible [LOAD-008].
- It ships `interface/divisiondesignerview.gui` under the game's own file name, so it replaces the whole vanilla file for every mod loaded with it [LOAD-010]; a single window in a later-sorting file would replace only that window [LOAD-001].

## Mod invariants
- The code fills a widget by its `name`, looked up inside its vanilla parent [GUW-001] [GUW-014]: never rename or reparent `division_names`, `expanded_window`, `names_grid`, `designer_div_name_group_entry` or `name`.
- Expandable windows use tiled sprites with border margins, which take the size of their window and keep the border [SPR-001].
- GUI syntax and procedure come from the user-level `hoi4-gui-modding` skill; this repository keeps no copy of it.

## Commands beyond build.ps1
- None.

## Read when
| Task | Read |
|---|---|
| Any change to the window | the `hoi4-gui-modding` skill, then `tests/GuiLayout.Tests.ps1` for what the tests pin |

## Engine Knowledge
- Engine facts live in the Modding Manager's register, reached through the user-level `hoi4-modding-knowledge` skill: search it before a new kind of file and before asking for a game launch, cite ids here, never write a fact into this repository.
- Topics this mod leans on: `gui-widgets`, `gui-layout`, `gui-sprites-and-fonts`, `loading-and-overrides`.
- `tests/Knowledge.Tests.ps1` runs the register's audit for this repository; it is a copy the Manager keeps current.
