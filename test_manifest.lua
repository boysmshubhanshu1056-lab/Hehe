package.path = "src/?.lua;src/?/init.lua;" .. package.path

local manifest = require("matrix_hub.manifest")
local Settings = require("matrix_hub.settings")

assert(manifest.title == "Matrix Hub")
local tabs, ids = {}, {}
for _, tab in ipairs(manifest.tabs) do
    tabs[tab.id] = true
    for _, item in ipairs(tab.settings) do
        assert(not ids[item.id], "Duplicate setting id: " .. item.id)
        ids[item.id] = true
        assert(item.label and item.type, "Every setting needs a label and type")
    end
end
assert(tabs.general and tabs.combat and tabs.visual and tabs.blacklist)
assert(not tabs["fast-flags"] and not tabs.fastflags)
assert(not ids.no_animation and not ids.hide and not ids.close_script)

local settings = Settings.new(nil)
assert(settings:get("fov_radius") == 200)
settings:set("fov_radius", 350)
assert(settings:get("fov_radius") == 350)
assert(settings:get("blacklist_fruit_tap") == false)

print("Matrix Hub manifest/settings tests passed.")
