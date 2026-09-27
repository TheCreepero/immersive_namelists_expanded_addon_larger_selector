# Immersive Namelists Expanded - Addon: Larger Selector — Development Rules

## 1. Mod Architecture & Purpose
- **Mod Role**: Lightweight quality-of-life UI addon expanding the division namelist selection dropdown in Hearts of Iron IV's Division Designer (`countrydivisiondesignerview`).
- **Checksum Invariant**: This mod alters only UI definitions in `interface/` and maintains 100% Ironman, achievement, and multiplayer compatibility.
- **Two-Level Workspace Layout**:
  - **Outer workspace root**: `C:\dev\immersive-namelists-expanded-addon-larger-selector` (build forwarders, dev assets, root `GEMINI.md`).
  - **Inner mod repository**: `C:\dev\immersive-namelists-expanded-addon-larger-selector\immersive_namelists_expanded_addon_larger_selector` (Git repository root containing `.git/`, `descriptor.mod`, `interface/`, `build.ps1`, `tests/`).
- **Dual-Path Synchronization Invariant**:
  - `GEMINI.md` exists in duplicate (at the workspace root and inside the inner mod repository).
  - Whenever updating rules, instructions, or documentation, keep both `GEMINI.md` copies 100% identical.

## 2. Clausewitz GUI Invariants & Standards
- **UTF-8 Without BOM**: All Clausewitz interface and script files (`.gui`, `.gfx`, `.mod`) must strictly be saved in UTF-8 without BOM (`[System.Text.UTF8Encoding]::new($false)`). Never use standard Windows PowerShell `Set-Content -Encoding UTF8` because it writes a BOM (`\ufeff`), which breaks Clausewitz parser loading.
- **Hardcoded Widget Names**: C++ binds GUI elements exclusively by `name = "..."`. Never rename existing vanilla element names (`division_names`, `expanded_window`, `names_grid`, `designer_div_name_group_entry`, `name`).
- **Strict Bracket & Quote Balancing**: All curly brackets `{}` and string quotes `""` must remain strictly balanced.
- **Tiled Windows & Scaling**: Expandable windows must use proper tiled window textures with defined border margins so background borders scale cleanly without distortion.

## 3. Build & Test Protocol
- Always run pre-flight syntax, bracket balance, and descriptor checks before declaring work complete:
  ```powershell
  powershell -File .\build.ps1 -ValidateOnly
  ```
- Run the full automated Pester test suite:
  ```powershell
  powershell -File .\build.ps1 -Test
  ```
- Use `.\build.ps1 -DevLink` for zero-copy live editing directly from the repository into the Paradox Launcher.
- Use `.\build.ps1 -Deploy` to create a mirrored local deployment copy in Paradox's `mod/` directory.
- Use `.\build.ps1 -Package` to verify clean staging and distribution packaging (strictly excluding `.git`, `.github`, `.vscode`, `tests`, `wiki`, and developer scripts).

## 4. Git & Commit Guidelines
- Do not commit to the Git repository unless explicitly instructed by the user. The user prefers to review changes before committing.
- After completing changes, always verify `git status` in the inner mod folder to ensure the working tree reflects expected changes.
