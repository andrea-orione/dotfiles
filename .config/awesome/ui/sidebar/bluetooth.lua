local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local icon = wibox.widget.textbox()
icon.font = beautiful.font_name .. ' 22'
icon.align = 'center'
icon.valign = 'center'
icon.markup = "<span foreground='#000000'>󰂯</span>"

local bluetooth = wibox.container.background(icon, beautiful.light_blue)
bluetooth.forced_width = dpi(50)
bluetooth.forced_height = dpi(50)
bluetooth.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end

local stat = true

bluetooth:buttons(gears.table.join(
	awful.button({ }, 1, function()
		stat = not stat
		if stat then
			icon.markup = "<span foreground='#000000'>󰂯</span>"
			bluetooth.bg = beautiful.light_blue
			awful.spawn.with_shell "bluetoothctl power on"
		else
			icon.markup = "<span foreground='" .. beautiful.fg_normal .. "'>󰂲</span>"
			bluetooth.bg = beautiful.bar_alt
			awful.spawn.with_shell "bluetoothctl power off"
		end
	end)
))

return bluetooth
