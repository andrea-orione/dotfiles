local awesome = awesome
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

----- Client/Windows/Apps/Idk what to say... -----

-- screen[1].padding = {
-- 	top = beautiful.xresources.apply_dpi(0),
-- 	bottom = beautiful.xresources.apply_dpi(0),
-- 	left = beautiful.xresources.apply_dpi(0),
-- 	right = beautiful.xresources.apply_dpi(0)
-- }

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    --- Rounded Border/s
	c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end
    
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

--- Focus when cursor enter any client
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Add title bar if floating
-- Client
client.connect_signal("property::floating", function(c)
    if c.floating and not c.requests_no_titlebar then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
  end)
-- Tag
awful.tag.attached_connect_signal(nil, "property::layout", function (t)
    local float = t.layout.name == "floating"
    for _,c in pairs(t:clients()) do
        c.floating = float
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
