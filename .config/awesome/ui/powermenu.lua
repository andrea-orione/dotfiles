local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local lain = require("lain")

local my_table = awful.util.table or gears.table -- bindings table 4.{0,1} compatibility
local markup = lain.util.markup

-- PAGE {{{
local logout = wibox {
	visible = false,
	ontop = true,
	bg = beautiful.black .. "22",
	type = 'dock',
}

awful.placement.maximize(logout)

-- TODO Add resizing signal

local keylock = awful.keygrabber {
	autostart = false,
	stop_event = 'release',
	keypressed_callback = function(self, mod, key, command)
		if key == "Escape" then
			awesome.emit_signal("logout::toggle")
		end
	end
}

local toggle = function()
	if logout.visible then
		keylock:stop()
	else
		keylock:start()
	end
	logout.visible = not logout.visible
end

logout:buttons(my_table.join(
	awful.button({ }, 1, function()
		toggle()
	end)
))

awesome.connect_signal("logout::toggle", function()
	toggle()
end)
-- }}}

-- WIDGETS {{{
-- Greeting
local greeting = wibox.widget.textbox()
greeting.font = beautiful.font_name .. " Regular Italic 42"
greeting.align = "center"
greeting.markup = "May the force be mass times acceleration"
--greeting.markup = "Rest well, " .. string.gsub(os.getenv('USER'), "^%l", string.upper)

-- Clock
local clock = wibox.widget.textclock(markup(beautiful.white "%H:%M"))
clock.font = beautiful.font_name .. " Bold 142"
clock.align = "center"

-- Powermenu
local function create_button(text, desc, color, command)
	local text_var = wibox.widget.textbox()
	local desc_var = wibox.widget.textbox()
	
	text_var.font = beautiful.font_name .. " 38"
	desc_var.font = beautiful.font_name .. " 12"

	text_var.align = "center"
	desc_var.align = "center"

	text_var.markup = "<span foreground='" .. color .. "'>" .. text .. "</span>"
	desc_var.markup = desc

	local widget = wibox.widget {
		text_var,
		desc_var,
		spacing = 10, -- beautiful.xresources.apply_dpi(10)
		layout = wibox.layout.fixed.vertical,
	}

	widget:buttons(my_table.join(
		awful.button({ }, 1, function()
			awful.spawn.with_shell(command)
		end)
	))

	return widget
end

local poweroff = create_button("󰐥", "PowerOff", beautiful.red, "poweroff")
local reboot = create_button("󰜉", "Reboot", beautiful.yellow, "reboot")
local sleeping = create_button("󰤄", "Sleep", beautiful.blue, "systemctl suspend")
local logging_out = create_button("󰌾", "Logout", beautiful.green, "pkill awesome")
-- }}}

-- PLACING {{{
local middle = wibox.widget {
	nil,
	{
		nil,
		{
			clock,
			greeting,
			poweroff,
			spacing = 5, -- beautiful.xresources.apply_dpi(5)
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	expand = 'none',
	layout = wibox.layout.align.vertical,
}

local right = wibox.widget {
	{
		nil,
		{
			poweroff,
			reboot,
			sleeping,
			logging_out,
			spacing = 40, -- beautiful.xresources.apply_dpi(40)
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.vertical,
	},
	margins = {right = 40}, -- beautiful.xresources.apply_dpi(40)
	widget = wibox.container.margin,
}

logout:setup {
	nil,
	middle,
	right,
	layout = wibox.layout.align.horizontal,
}
-- }}}