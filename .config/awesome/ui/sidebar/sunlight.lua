local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local icon = wibox.widget.textbox()
icon.font = beautiful.font_name .. ' 22'
icon.align = 'center'
icon.valign = 'center'
icon.markup = "<span foreground='#000000'>󰃟</span>"

local sun = wibox.widget {
        icon,
        forced_width = dpi(50),
        forced_height = dpi(50),
        shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
        bg = beautiful.light_blue,
        widget = wibox.container.background,
}

local stat = true -- Internet on

sun:buttons(gears.table.join(
        awful.button({ }, 1, function()
                stat = not stat
                if stat then
                        icon.markup = "<span foreground='#000000'>󰃟</span>"
                        sun.bg = beautiful.light_blue
                        awful.spawn.with_shell "pkill -USR1 redshift"
                else
                        icon.markup = "<span foreground='" .. beautiful.fg_normal .. "'>󰃟</span>"
                        sun.bg = beautiful.bar_alt
                        awful.spawn.with_shell "pkill -USR1 redshift"
                end
        end)
))

return sun
