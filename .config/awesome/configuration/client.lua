local awful = require("awful")
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

----- Client/Windows/Apps/Idk what to say... -----

-- screen[1].padding = {
-- 	top = dpi(0),
-- 	bottom = dpi(0),
-- 	left = dpi(0),
-- 	right = dpi(0)
-- }

--- Rounded Border/s

client.connect_signal("manage", function(c)
	c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end
end)

--- Focus when cursor enter any client

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
