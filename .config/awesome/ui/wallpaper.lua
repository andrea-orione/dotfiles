local os, io, root, math = os, io, root, math

local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local cairo = require("lgi").cairo --Wallpaper transition


local function set_wallpaper(wallpaper, s)
    awful.spawn.with_shell("feh --bg-scale ~/.wallpapers/" .. wallpaper)
end

local function reset_current_wallpaper(s)
    local old_wp = gears.surface(root.wallpaper())
    set_wallpaper(old_wp, s)
end

 -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
 -- TODO change this to match the modifications
screen.connect_signal("property::geometry", reset_current_wallpaper)

local function scanDir(directory)
    local c, fileList = 0, {}
    local pfiles = io.popen([[find "]] .. directory .. [[" -type f]])
    for fileName in pfiles:lines() do
        c = c + 1
        fileList[c] = fileName
    end
    return fileList
end

local function mix_surfaces(first, second, factor)
    local result = gears.surface.duplicate_surface(first)
    local cr = cairo.Context(result)
    cr:set_source_surface(second, 0, 0)
    cr:paint_with_alpha(factor)
    return result
end

local function fade_to_wallpaper(new_wp, steps, interval, screen)
    new_wp = gears.surface(new_wp)
    local old_wp = gears.surface(root.wallpaper())
    if not old_wp then
        callback(new_wp)
        return
    end
    old_wp = gears.surface.duplicate_surface(old_wp)
    local steps_done = 0
    gears.timer.start_new(interval, function()
        steps_done = steps_done + 1
        local mix = mix_surfaces(old_wp, new_wp, steps_done / steps)
        set_wallpaper(mix, screen)
        mix:finish()
        return steps_done <= steps
    end)
end

function draw_changing_wallpaper(scr)
    math.randomseed(os.time())
    local wallpaperList = scanDir(beautiful.wallpapers_folder)
    set_wallpaper(wallpaperList[math.random(1, #wallpaperList)], scr)
    local changing_time = 1800
    wallpaper_timer = gears.timer{
        timeout = changing_time,
        call_now = true,
        autostart = true,
        callback = function()
            fade_to_wallpaper(wallpaperList[math.random(1, #wallpaperList)], 90, 1/30, scr)
        end
    }
end