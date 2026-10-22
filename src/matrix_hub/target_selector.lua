-- Engine-agnostic target selection for your own game's exposed player/camera data.
-- Input targets must be records supplied by your own game, not memory scans/hooks.
local Selector = {}

local function distance(a, b)
    local dx, dy, dz = a.x - b.x, a.y - b.y, a.z - b.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

local function dot(a, b)
    return a.x * b.x + a.y * b.y + a.z * b.z
end

local function normalized(v)
    local m = math.sqrt(v.x*v.x + v.y*v.y + v.z*v.z)
    if m == 0 then return nil end
    return { x = v.x/m, y = v.y/m, z = v.z/m }
end

local function angle_degrees(a, b)
    local na, nb = normalized(a), normalized(b)
    if not na or not nb then return 180 end
    local d = math.max(-1, math.min(1, dot(na, nb)))
    return math.deg(math.acos(d))
end

-- camera: { position={x,y,z}, forward={x,y,z} }
-- targets: { {id, position={x,y,z}, health, alive, isLookingAtMe, isVisible, team, ...}, ... }
-- opts: max_range, aim_mode ("360"|"180"|"FOV"), fov_radius (degrees for this engine-neutral core),
-- priority ("Nearest"|"Low HP"|"Looking At Me"), include_team (boolean)
function Selector.select(camera, targets, opts)
    if type(camera) ~= "table" or type(camera.position) ~= "table" or type(camera.forward) ~= "table" then
        return nil, "camera position/forward are required"
    end
    opts = opts or {}
    local max_range = tonumber(opts.max_range) or 1000
    local fov_radius = tonumber(opts.fov_radius) or 20
    local mode = opts.aim_mode or "FOV"
    local priority = opts.target_priority or "Nearest"
    local candidates = {}

    for _, target in ipairs(targets or {}) do
        if target and target.position and target.alive ~= false and target.isValid ~= false then
            local d = distance(camera.position, target.position)
            local direction = {
                x = target.position.x - camera.position.x,
                y = target.position.y - camera.position.y,
                z = target.position.z - camera.position.z
            }
            local angle = angle_degrees(camera.forward, direction)
            local allowed = d <= max_range
            if mode == "180" then allowed = allowed and angle <= 90
            elseif mode == "FOV" then allowed = allowed and angle <= fov_radius
            elseif mode ~= "360" then allowed = false end
            if target.isVisible == false then allowed = false end
            if target.sameTeam == true and opts.include_team ~= true then allowed = false end
            if allowed then
                candidates[#candidates + 1] = { target = target, distance = d, angle = angle, health = tonumber(target.health) or math.huge,
                    looking = target.isLookingAtMe == true }
            end
        end
    end

    table.sort(candidates, function(a, b)
        if priority == "Low HP" and a.health ~= b.health then return a.health < b.health end
        if priority == "Looking At Me" and a.looking ~= b.looking then return a.looking end
        if priority == "Looking At Me" and a.angle ~= b.angle then return a.angle < b.angle end
        if a.distance ~= b.distance then return a.distance < b.distance end
        return tostring(a.target.id or "") < tostring(b.target.id or "")
    end)
    return candidates[1] and candidates[1].target or nil
end

return Selector
