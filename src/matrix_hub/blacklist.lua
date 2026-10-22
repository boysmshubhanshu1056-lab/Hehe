local Blacklist = {}

local valid = {
    melee = { Z = true, X = true, C = true },
    sword = { Z = true, X = true },
    fruit = { Z = true, X = true, C = true, V = true, F = true, TAP = true },
    gun = { Z = true, X = true },
}

function Blacklist.is_blocked(settings, category, key)
    category, key = string.lower(tostring(category or "")), string.upper(tostring(key or ""))
    if not (valid[category] and valid[category][key]) then
        return false, "Unknown category/key"
    end
    local id = "blacklist_" .. category .. "_" .. string.lower(key)
    return settings:get(id) == true
end

function Blacklist.filter(category, key, settings, execute_ability)
    if Blacklist.is_blocked(settings, category, key) then
        return false, "Ability blocked by Matrix Hub blacklist"
    end
    if type(execute_ability) ~= "function" then
        return false, "No ability callback provided"
    end
    return execute_ability()
end

return Blacklist
