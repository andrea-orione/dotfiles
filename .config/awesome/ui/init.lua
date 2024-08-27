local awful = require("awful")
require("awful.autofocus")

require("ui.wallpaper")
require("ui.titlebar")
require("ui.bar")
require("ui.popup")
require("ui.powermenu")
require("ui.ping")

Draw_changing_wallpaper()

awful.screen.connect_for_each_screen(
    function(s)
        Draw_bar_at_the_top(s)
    end
)
