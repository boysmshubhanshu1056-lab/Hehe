local Manifest = require("matrix_hub.manifest")

local Settings = {}
Settings.__index = Settings

function Settings.new(storage)
    local self = setmetatable({ values = {}, storage = storage }, Settings)
    for _, tab in ipairs(Manifest.tabs) do
        for _, item in ipairs(tab.settings) do
            self.values[item.id] = item.default
        end
    end
    if storage and storage.load then
        local saved = storage:load()
        if type(saved) == "table" then
            for key, value in pairs(saved) do
                if self.values[key] ~= nil then self.values[key] = value end
            end
        end
    end
    return self
end

function Settings:get(key) return self.values[key] end

function Settings:set(key, value)
    assert(self.values[key] ~= nil, "Unknown setting: " .. tostring(key))
    self.values[key] = value
    if self.storage and self.storage.save then self.storage:save(self.values) end
end

function Settings:all()
    local copy = {}
    for k, v in pairs(self.values) do copy[k] = v end
    return copy
end

return Settings
