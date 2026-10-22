-- Matrix Hub setting manifest based on the supplied reference.
-- Fast Flags and the General actions No Animation / HIDE / CLOSE THIS SCRIPT are omitted.

return {
    title = "Matrix Hub",
    theme = {
        panel = { 24, 30, 44 },
        row = { 30, 37, 52 },
        accent = { 78, 158, 230 },
        text = { 225, 228, 235 },
        textDim = { 130, 138, 152 },
        sliderTrack = { 45, 52, 68 },
        toggleOff = { 68, 76, 92 },
        toggleOn = { 78, 158, 230 },
        panelWidth = 450,
        panelHeight = 460,
        rowHeight = 28,
        tabHeight = 36,
        titleHeight = 40,
    },
    tabs = {
        {
            id = "general", title = "General",
            settings = {
                { id = "show_fps", type = "toggle", label = "Show FPS", default = true },
            },
        },
        {
            id = "combat", title = "Combat",
            settings = {
                { id = "player_target_assist", type = "toggle", label = "Player Target Assist", default = false },
                { id = "show_fov_circle", type = "toggle", label = "Show FOV Circle", default = true },
                { id = "aim_mode", type = "cycle", label = "Aim Mode", options = { "360", "180", "FOV" }, default = "FOV" },
                { id = "target_priority", type = "cycle", label = "Target Priority", options = { "Nearest", "Low HP", "Looking At Me" }, default = "Nearest" },
                { id = "fov_radius", type = "slider", label = "FOV Radius", min = 10, max = 800, default = 200 },
                { id = "max_range", type = "slider", label = "Max Range", min = 100, max = 3000, default = 1000 },
                { id = "soru_auto_aim", type = "toggle", label = "Soru Target Assist", default = false },
                { id = "soru_range", type = "slider", label = "Soru Range", min = 10, max = 3000, default = 300 },
            },
        },
        {
            id = "visual", title = "Visual",
            settings = {
                { id = "esp", type = "toggle", label = "ESP", default = false },
                { id = "esp_outline", type = "toggle", label = "Outline", default = true },
                { id = "esp_filled_body", type = "toggle", label = "Filled Body", default = false },
                { id = "esp_name", type = "toggle", label = "Name", default = true },
                { id = "esp_distance", type = "toggle", label = "Distance", default = true },
                { id = "esp_health_bar", type = "toggle", label = "Health Bar", default = true },
                { id = "esp_show_all_players", type = "toggle", label = "Show All Players", default = false },
            },
        },
        {
            id = "blacklist", title = "Blacklist",
            settings = {
                { id = "blacklist_melee_z", type = "toggle", label = "Melee — Z", default = false },
                { id = "blacklist_melee_x", type = "toggle", label = "Melee — X", default = false },
                { id = "blacklist_melee_c", type = "toggle", label = "Melee — C", default = false },
                { id = "blacklist_sword_z", type = "toggle", label = "Sword — Z", default = false },
                { id = "blacklist_sword_x", type = "toggle", label = "Sword — X", default = false },
                { id = "blacklist_fruit_z", type = "toggle", label = "Fruit — Z", default = false },
                { id = "blacklist_fruit_x", type = "toggle", label = "Fruit — X", default = false },
                { id = "blacklist_fruit_c", type = "toggle", label = "Fruit — C", default = false },
                { id = "blacklist_fruit_v", type = "toggle", label = "Fruit — V", default = false },
                { id = "blacklist_fruit_f", type = "toggle", label = "Fruit — F", default = false },
                { id = "blacklist_fruit_tap", type = "toggle", label = "Fruit — TAP", default = false },
                { id = "blacklist_gun_z", type = "toggle", label = "Gun — Z", default = false },
                { id = "blacklist_gun_x", type = "toggle", label = "Gun — X", default = false },
            },
        },
    },
}
