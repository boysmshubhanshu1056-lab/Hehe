local Manifest = require("matrix_hub.manifest")
local Settings = require("matrix_hub.settings")
local Adapter = require("matrix_hub.adapter")

local MatrixHub = {}

function MatrixHub.start(engine_api, storage)
    local settings = Settings.new(storage)
    local adapter = Adapter.new(engine_api)
    local function on_setting_changed(id, value)
        settings:set(id, value)
        if id:match("^esp") then
            adapter:update_developer_visuals(settings)
        end
    end
    adapter:render_menu(Manifest, settings, {
        on_setting_changed = on_setting_changed,
        get_setting = function(id) return settings:get(id) end,
        get_all_settings = function() return settings:all() end,
    })
    return { manifest = Manifest, settings = settings, adapter = adapter }
end

return MatrixHub
