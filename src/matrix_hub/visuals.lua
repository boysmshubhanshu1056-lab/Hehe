-- Sends visualization settings to the game's supported debug/overlay renderer.
local Visuals = {}
Visuals.__index = Visuals

function Visuals.new(engine_api, settings)
    return setmetatable({ api = engine_api, settings = settings, active = false }, Visuals)
end

function Visuals:update()
    if not self.api.render_developer_overlays then
        return false, "Implement render_developer_overlays in your engine adapter"
    end
    local opts = {
        enabled = self.settings:get("esp"),
        outline = self.settings:get("esp_outline"),
        filled_body = self.settings:get("esp_filled_body"),
        name = self.settings:get("esp_name"),
        distance = self.settings:get("esp_distance"),
        health_bar = self.settings:get("esp_health_bar"),
        show_all_players = self.settings:get("esp_show_all_players"),
    }
    self.active = opts.enabled == true
    return self.api.render_developer_overlays(opts)
end

return Visuals
