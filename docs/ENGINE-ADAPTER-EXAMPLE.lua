-- EXAMPLE ONLY: replace every TODO with your own engine's supported APIs.
-- Do not ship this adapter unchanged; it deliberately fails on unimplemented methods.

local Example = {}

function Example.render_menu(manifest, settings, callbacks)
    error("TODO: draw tabs/controls with your engine UI API")
end

function Example.get_frame_stats()
    error("TODO: return current FPS/frame time from your engine")
end

function Example.get_camera_state()
    error("TODO: return camera world position and forward vector")
end

function Example.get_target_candidates()
    error("TODO: expose valid in-game target records from your own game")
end

function Example.get_local_position()
    error("TODO: return local character world position")
end

function Example.request_test_assist(kind, target, settings)
    error("TODO: call your own game's test-assist API; validate action server-side")
end

function Example.render_developer_overlays(options)
    error("TODO: draw or clear developer overlays using your engine")
end

return Example
