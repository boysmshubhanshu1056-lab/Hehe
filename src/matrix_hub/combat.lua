local Selector = require("matrix_hub.target_selector")
local Combat = {}
Combat.__index = Combat

function Combat.new(engine_api, settings)
    return setmetatable({ api = engine_api, settings = settings, last_target = nil }, Combat)
end

function Combat:choose_target()
    if not self.api.get_camera_state or not self.api.get_target_candidates then
        return nil, "Implement get_camera_state and get_target_candidates in your game adapter"
    end
    local camera = self.api.get_camera_state()
    local targets = self.api.get_target_candidates()
    local chosen, err = Selector.select(camera, targets, {
        max_range = self.settings:get("max_range"),
        fov_radius = self.settings:get("fov_radius"),
        aim_mode = self.settings:get("aim_mode"),
        target_priority = self.settings:get("target_priority"),
        include_team = self.settings:get("esp_show_all_players"),
    })
    self.last_target = chosen
    return chosen, err
end

function Combat:request_assist(kind)
    local enabled_key = kind == "soru" and "soru_auto_aim" or "player_target_assist"
    if self.settings:get(enabled_key) ~= true then return false, "Feature is disabled" end
    local target, err = self:choose_target()
    if not target then return false, err or "No eligible target" end
    if kind == "soru" then
        local pos = self.api.get_local_position and self.api.get_local_position()
        if pos and target.position then
            local dx, dy, dz = pos.x-target.position.x, pos.y-target.position.y, pos.z-target.position.z
            local dist = math.sqrt(dx*dx + dy*dy + dz*dz)
            if dist > (tonumber(self.settings:get("soru_range")) or 300) then
                return false, "Target is outside Soru range"
            end
        end
    end
    -- This must call your own game's supported test-assist API; server validates the action.
    if not self.api.request_test_assist then return false, "Implement request_test_assist in your game adapter" end
    return self.api.request_test_assist(kind, target, self.settings:all())
end

return Combat
