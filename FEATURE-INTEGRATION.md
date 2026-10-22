# Feature integration checklist

All entries below are represented in the setting manifest. They are **not advertised as fully game-functional yet**: connect the adapter to the actual game API first.

- [ ] General: Show FPS (read actual frame timing/FPS from engine)
- [ ] Combat: Player Target Assist (own-game target selection + server-validated combat request)
- [ ] Combat: FOV Circle (draw through engine UI/debug drawing API)
- [ ] Combat: Aim Mode (360 / 180 / FOV filtering)
- [ ] Combat: Target Priority (Nearest / Low HP / Looking At Me)
- [ ] Combat: FOV Radius
- [ ] Combat: Max Range
- [ ] Combat: Soru Target Assist (own game's movement/ability API; server validation)
- [ ] Combat: Soru Range
- [ ] Visual: ESP / outline / filled body / name / distance / health bar / show all players
- [ ] Blacklist: Melee Z/X/C; Sword Z/X; Fruit Z/X/C/V/F/TAP; Gun Z/X
- [ ] UI: match supplied Matrix Hub colors/sizing; tabs; toggle/slider/cycler controls; drag; floating open button
- [ ] Settings persistence using your engine's supported storage

## Required adapter APIs

The `engine_api` passed to `MatrixHub.start(engine_api, storage)` needs:

- `render_menu(manifest, settings, callbacks)`: construct the menu in your engine's UI system. Call `callbacks.on_setting_changed(id, value)` when controls change.
- `get_frame_stats()`: return real frame stats, e.g. `{ fps = 60, frame_ms = 16.7 }`.
- `update_developer_visuals(settings)`: update or clear the engine's own debug overlays.
- `select_target(settings)`: return a valid target chosen from your game's own player/camera data.
- `request_test_assist(target, settings)`: request the controlled test assist through the game's supported combat API. The server must independently validate targets, range, state, and hit outcomes.

You can omit optional methods while building the UI, but the corresponding feature will not operate until implemented.
