# Immersive Namelists Expanded - Addon: Larger Selector

A lightweight quality-of-life UI addon for Hearts of Iron IV that expands and improves the division namelist selection dropdown in the Division Designer.

## Overview

- **Game**: Hearts of Iron IV
- **Supported Version**: 1.19.*
- **Mod Version**: 1.0
- **Tags**: Utilities, Fixes
- **Ironman & Achievements**: 100% Compatible (Checksum Neutral)

---

## Directory Architecture

This repository adheres to the standard two-level Hearts of Iron IV mod architecture:
- **Outer Root**: Contains workspace build tools, dev assets, and launch configurations.
- **Inner Mod Root** (`immersive_namelists_expanded_addon_larger_selector/`): The actual mod repository containing content files, descriptors, tests, and build engine.

```
C:\dev\immersive-namelists-expanded-addon-larger-selector/
|-- build.ps1                       # Root build forwarding script
|-- build.bat                       # Quick packaging shortcut
|-- build_and_deploy.bat            # Quick deploy shortcut
|-- assets/                         # Raw graphics and art assets
`-- immersive_namelists_expanded_addon_larger_selector/  # Git repository root & mod content
    |-- descriptor.mod              # Clausewitz engine descriptor
    |-- thumbnail.png               # Steam Workshop thumbnail (512x512)
    |-- build.ps1                   # Core build and lifecycle engine
    |-- interface/                  # UI overrides (divisiondesignerview.gui)
    |-- tests/                      # Automated Pester test suites
    `-- wiki/                       # GitHub documentation wiki
```

---

## Development & Automation Commands

All lifecycle tasks are managed through `build.ps1`:

```powershell
# 1. Deploy mod to local Paradox Interactive Hearts of Iron IV mod folder
.\build.ps1 -Deploy

# 2. Configure zero-copy DevLink (instant hot-reload for live testing)
.\build.ps1 -DevLink

# 3. Validate syntax, bracket balance, and UTF-8 BOM without deploying
.\build.ps1 -ValidateOnly

# 4. Run automated test suites (Pester)
.\build.ps1 -Test

# 5. Package clean release zip archive
.\build.ps1 -Package

# 6. Publish to Steam Workshop (Dry Run preview)
.\build.ps1 -PublishSteam -DryRun

# 7. Clean deployed mod files and temporary archives
.\build.ps1 -Clean
```

---

## Automated Testing

Unit tests are written with [Pester](https://pester.dev) and located in `tests/`. Execute tests using:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\Run-Tests.ps1
```

---

## Author & License

- **Author**: TheCreepero