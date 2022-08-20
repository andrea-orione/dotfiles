local awful = require("awful")
require("awful.autofocus")
local lain = require("lain")

require("ui.wallpaper")
require("ui.menu")
require("ui.titlebar")
require("ui.bar")
require("ui.popup")
require("ui.powermenu")
--require("ui.sidebar")
require("ui.ping")
require("ui.dashboard")

awful.screen.connect_for_each_screen(
    function(s) 
        -- Quake application
        s.quake = lain.util.quake({ app = awful.util.terminal })
        -- s.quake = lain.util.quake({ app = "termite", height = 0.50, argname = "--name %s" })
        draw_changing_wallpaper(s)
        draw_bar_at_the_top(s)
    end
)