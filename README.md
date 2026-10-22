# Matrix Hub — Own-Game Starter

This is a **source starter**, not a finished drop-in iOS `.dylib`. Your game engine and its UI/game APIs have not been identified yet, so no honest project can make every game-specific feature functional until those integration points are connected.

## Included
- Matrix Hub-style dark slate/blue UI definition and tab/setting manifest
- General, Combat, Visual, and Blacklist tabs
- No Animation, HIDE, CLOSE THIS SCRIPT, and all Fast Flags features removed
- Feature adapter contract for your own game's supported API
- Lua syntax/test workflow for GitHub Actions
- Integration checklist and feature inventory

## Important
The menu is deliberately **not an exploit/injector**. Combat targeting must run through your own game's supported code and server-authoritative hit validation. ESP is a developer visualization for your own game. The adapter functions are explicit integration points: they must be implemented using your engine's real APIs before game-specific features can work.

A `.dylib` built for macOS is not an iOS `.dylib`. iOS libraries need the correct SDK, architecture, signing, packaging, and a host app/plugin-loading path. This repository does not falsely claim to produce a usable iOS library without those details.

## GitHub upload
1. Extract `MatrixHub-OwnGame-Starter.zip`.
2. Open the extracted `MatrixHub-OwnGame-Starter` folder.
3. Create a **new empty repository** on GitHub.
4. Upload the *contents* of this folder (not the outer ZIP) to the repository root.
5. Open **Actions**. The workflow checks Lua syntax and runs the basic tests.

## Before making a real iOS build
Identify:
- Game engine/framework and version
- How the game embeds/runs Lua
- Whether the game supports native plugins/dynamic libraries
- The supported UI API
- The player, camera, ability, and server-hit-validation APIs

Once those are known, the adapter can be wired to real APIs instead of placeholders.


## Expanded implementation core
The repository now includes an engine-neutral target selector, ability blacklist filtering, combat-assist orchestration, developer-visual configuration, and an iOS build-path guide. These modules execute their own logic, but game features only become operational when you implement the documented adapter functions against your custom engine.

Read `docs/IOS-BUILD-PATH.md` and `docs/FEATURE-INTEGRATION.md` before integrating.
