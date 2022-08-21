local awesome, os = awesome, os
local beautiful = require("beautiful")
local awful = require("awful")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

local dpi = beautiful.xresources.apply_dpi

local function scr()
    local time = os.date("%y-%m-%d_%H:%M:%S")
    local location = "/tmp/" .. time .. ".png"
    local script = [[maim | tee /tmp/]] .. time .. [[.png | xclip -selection clipboard -t image/png notify-send -i ]] .. location .. [[ "Kashott!" "Screenshot copied to clipboard"]]
    awful.spawn.with_shell(script)
end

myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual", terminal .. " -e man awesome" },
    { "Edit config", editor_cmd .. " " .. awesome.conffile },
    { "Restart", awesome.restart },
}
 
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or dpi(16),
    before = { 
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
    },
    after = {
        { "Terminal", terminal },
        { "Browser", browser },
        { "File manager", fileManager},
        -- { "Screeenshot", function() scr() end },
        -- { "Power", function() awesome.emit_signal("ui::powermenu:open")
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Reboot", "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" }
    }
})