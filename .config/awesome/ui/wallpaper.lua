local root = root

local gears = require("gears")
local awful = require("awful")

local function set_wallpaper(wallpaper, s)
    awful.spawn.with_shell("feh --bg-scale " .. wallpaper)
end

local function set_random_wallpaper()
    awful.spawn.with_shell("feh --bg-scale --randomize ~/.wallpapers/*")
end

local function reset_current_wallpaper(s)
    local old_wp = gears.surface(root.wallpaper())
    set_wallpaper(old_wp, s)
end

 -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
 -- TODO change this to match the modifications
screen.connect_signal("property::geometry", reset_current_wallpaper)

function Draw_changing_wallpaper()
    set_random_wallpaper()
    local changing_time = 1800
    Wallpaper_timer = gears.timer{
        timeout = changing_time,
        call_now = true,
        autostart = true,
        callback = function()
            set_random_wallpaper()
        end
    }
end
