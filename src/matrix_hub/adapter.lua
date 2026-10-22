-- Implement these functions using your own game's supported engine APIs.
-- No metatable hooks, remote interception, process injection, or anti-cheat bypasses.
local Adapter = {}
Adapter.__index = Adapter

function Adapter.new(engine_api)
    assert(type(engine_api) == "table", "Pass your game's supported API adapter")
    return setmetatable({ api = engine_api }, Adapter)
end

function Adapter:render_menu(manifest, settings, callbacks)
    assert(self.api.render_menu, "Missing engine_api.render_menu")
    return self.api.render_menu(manifest, settings, callbacks)
end

function Adapter:get_frame_stats()
    if not self.api.get_frame_stats then return nil end
    return self.api.get_frame_stats()
end

function Adapter:update_developer_visuals(settings)
    if not self.api.update_developer_visuals then
        return false, "Implement update_developer_visuals with your engine's debug/visual API"
    end
    return self.api.update_developer_visuals(settings)
end

function Adapter:select_target(settings)
    if not self.api.select_target then
        return nil, "Implement select_target using your own game's player/camera data"
    end
    return self.api.select_target(settings)
end

function Adapter:request_test_assist(target, settings)
    -- The game/server must validate any hit or ability request.
    if not self.api.request_test_assist then
        return false, "Implement a test-only assist through your game's supported combat API"
    end
    return self.api.request_test_assist(target, settings)
end

function Adapter:filter_ability(category, key, settings)
    local id = "blacklist_" .. string.lower(category) .. "_" .. string.lower(key)
    if key == "TAP" then id = "blacklist_fruit_tap" end
    return settings:get(id) == true
end

return Adapter
