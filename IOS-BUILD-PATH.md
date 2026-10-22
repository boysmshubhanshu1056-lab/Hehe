# iOS build path for a custom game with embedded Lua

## Recommended route: compile/link into your own signed game app

For an iPad/iOS game that you own, the most reliable route is to integrate Matrix Hub's Lua modules into the game's existing embedded Lua runtime and build/sign the host app through your normal Xcode project. Do not plan on injecting an arbitrary `.dylib` into another app.

### Route A — Lua modules bundled by the host app (recommended first)
1. Add `src/matrix_hub/*.lua` to your game's Lua script bundle.
2. Ensure your Lua package path includes the folder containing `matrix_hub/`.
3. Implement the `engine_api` functions listed in `FEATURE-INTEGRATION.md` using your engine's actual UI, player, camera, debug-overlay, and combat APIs.
4. Start it from your game's own initialization code:
   `local MatrixHub = require("matrix_hub.init")`
   `MatrixHub.start(engine_api, storage_adapter)`
5. Build and sign your game with its existing Xcode project / build system.

This gives the same Lua UI logic on iOS without needing a separately loadable library.

### Route B — native iOS framework/dynamic library
Use this only if your own app's architecture genuinely requires native code:
1. Create an Xcode target for a framework or dynamic library using the correct iOS SDK and device/simulator architectures.
2. Link it into your own host app, embed it where required, and sign the app and embedded binary together.
3. Expose a narrow C/Objective-C bridge to the embedded Lua runtime; avoid assuming Lua can load an arbitrary binary by filename.
4. Keep all native code within the app's signed, supported packaging and loading model.
5. Test on the actual iPad and simulator separately; simulator and device binaries are not interchangeable.

This repository does not include a fake prebuilt `.dylib`: the custom engine's headers, Lua library build, target architecture, signing setup, and host-app project are not available here. Without those, a binary would be guessed and likely unusable.

## Engine API contract
See `FEATURE-INTEGRATION.md`. At minimum, the host must provide:
- `render_menu(manifest, settings, callbacks)`
- `get_camera_state()` returning `{ position={x,y,z}, forward={x,y,z} }`
- `get_target_candidates()` returning valid candidate records from the game's own runtime
- `get_local_position()`
- `request_test_assist(kind, target, settings)` with server-side validation
- `render_developer_overlays(options)`
- `get_frame_stats()`
- storage `load()` / `save(settings)`

## Note on targeting settings
The engine-neutral selector interprets FOV radius as an angular threshold in degrees. If your UI expects a pixel radius on screen, implement the conversion in the engine adapter using the actual camera projection and viewport size. The reference's 10–800 values appear suited to a screen-space circle, so this is an integration detail that must be settled against your engine.
