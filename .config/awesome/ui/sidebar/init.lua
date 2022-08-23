local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")

local dpi = beautiful.xresources.apply_dpi
local markup = lain.util.markup

local rubato = require "lib.rubato"

-- VAR {{{
local scr = awful.screen.focused()

local border = dpi(2)
local width = dpi(320) - border -- To get desired width without border
local height = dpi(400) - border -- Same as width ^^^
local gaps = dpi(20)
local border_radius = 5
-- }}}

-- FUNCTIONS {{{
local function rr(cr,w,h)
	gears.shape.rounded_rect(cr,w,h,border_radius)
end

local function partial_rr(cr,w,h)
	gears.shape.partially_rounded_rect(cr,w,h,false,true,false,false, 32)
end

local function pad_h(pad)
	local res = wibox.container.background()
	res.forced_width = pad
	return res
end

local function pad_v(pad)
	local res = wibox.container.background()
	res.forced_height = pad
	return res
end

local function coloring_text(text, color)
	color = color or beautiful.white
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

local function create_box(widget, bg_color, border_width)
	local box_h_layout = wibox.layout.align.horizontal(nil, widget)
	box_h_layout.expand = "none"
	local box_v_layout = wibox.layout.align.vertical(nil, box_h_layout)
	box_v_layout.expand = "none"

	local container = wibox.container.background(box_v_layout)
	--container.forced_width = width
	--container.forced_height = height
	container.border_width = border_width or 0
	container.border_color = beautiful.bar_alt
	container.bg = bg_color or beautiful.transparent
	container.shape = rr

	local box_widget = wibox.container.margin(container)
	box_widget.margins = dpi(10)

	return box_widget
end
-- }}}

-- STRUCTURE {{{
local sidebar = wibox {
	visible = true,
	ontop = true,
	width = width,
	height = height,
	border_width = border,
	border_color = beautiful.light_blue,
	bg = beautiful.dark_blue,
	shape = rr,
	type = 'dock'
}

awful.placement.top_left(sidebar, { margins = {top = dpi(90)}})

--sidebar:struts {left = dpi(40 + sidebar.width)}

local slide = rubato.timed {
	pos = scr.geometry.x - sidebar.width,
	rate = 60,
	intro = 0.2,
	duration = 0.4,
	subscribed = function(pos)
		sidebar.x = scr.geometry.x + gaps + pos
	end
}

local timer = gears.timer {
	timeout = 0.4,
	call_now = true,
	single_shot = true,
	callback = function()
		sidebar.visible = not sidebar.visible
	end
}

local toggle = function()
	if sidebar.visible then
		slide.target = scr.geometry.x - sidebar.width -- x = 0 - sidebar's width
		timer:start()
	else
		slide.target = scr.geometry.x -- x = 0
		sidebar.visible = not sidebar.visible
	end
end

awesome.connect_signal("sidebar::toggle", function()
	toggle()
end)
-- }}}

-- WIDGETS {{{
-- Clock
local time = wibox.widget.textclock(markup(beautiful.white, "%H:%M"))
time.font = beautiful.font_name .. " Bold 42"

local date = wibox.widget.textclock(markup(beautiful.white, "%A %d %b"))
date.font = beautiful.font_name .. " Regular 14"
date.align = "center"

local clock_layout = wibox.layout.fixed.vertical(time, date)
local clock_widget = wibox.container.margin(clock_layout)
clock_widget.margins = { left = dpi(12), right = dpi(12), top = dpi(10), bottom = dpi(10) }

local clock = create_box(clock_widget, beautiful.transparent)

-- Separatorr
local separator_widget = wibox.container.background(nil, beautiful.transparent)
separator_widget.forced_height = dpi(5)

local separator = wibox.container.margin(separator_widget)
separator.margins = {bottom = dpi(20)}

-- Uptime
local uptime_widget = wibox.widget.textbox()
uptime_widget.font = beautiful.font_name .. " Regular 14"
uptime_widget.align = "center"

local get_uptime = function()
	awful.spawn.easy_async_with_shell('uptime -p', function(stdout)
		uptime_widget.markup = coloring_text(stdout)
	end)
end

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		get_uptime()
	end
}

-- Volume/Brightness
local function crt_icon(text, color)
	local icon_widget = wibox.widget.textbox()
	icon_widget.font = beautiful.font_name .. " 22"
	icon_widget.align = 'center'
	icon_widget.markup = coloring_text(text, color)

	return icon_widget
end

local volume_icon = crt_icon("󰋋", beautiful.blue)
local bright_icon = crt_icon("󰃟", beautiful.orange)

local function crt_slider(color)
	local slider_widget = wibox.widget.slider()
	slider_widget.forced_width = dpi(160)
	slider_widget.forced_height = dpi(38)
	slider_widget.bar_shape = gears.shape.rounded_rect
	slider_widget.bar_height = dpi(5)
	slider_widget.bar_color = beautiful.bar2
	slider_widget.bar_active_color = color
	slider_widget.handle_color = color
	slider_widget.handle_shape = gears.shape.circle

	return slider_widget
end

local volume_slider = crt_slider(beautiful.blue)
local bright_slider = crt_slider(beautiful.yellow)

local search_vol = true

local function get_volume()
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
      		local value = string.gsub(stdout, "^%s*(.-)%s*$", "%1")
       		volume_slider.value = tonumber(value)
	end)
end

local function get_brightness()
	awful.spawn.easy_async_with_shell("brightnessctl g", function(stdout)
        	local bri = tonumber(stdout)
		awful.spawn.easy_async_with_shell("brightnessctl m", function(stdout)
                	local max = tonumber(stdout)
                	local value = bri/max * 100
                	bright_slider.value = value
        	end)
	end)
end

gears.timer {
	timeout = 2,
	autostart = true,
	call_now = true,
	callback = function()
		get_volume()
		get_brightness()
	end
}

volume_slider:connect_signal("property::value", function(_, new_value)
        volume_slider.value = new_value
        awful.spawn("pamixer --set-volume " .. new_value, false)
end)

bright_slider:connect_signal('property::value', function(_, value)
	bright_slider.value = value
	awful.spawn.with_shell('brightnessctl set ' .. value .. '%')
end)

local volume_widget = wibox.layout.fixed.horizontal()
volume_widget.spacing = dpi(12)
volume_widget:add(volume_icon, volume_slider)

local bright_widget = wibox.layout.fixed.horizontal()
bright_widget.spacing = dpi(12)
bright_widget:add(bright_icon, bright_slider)

-- Buttons
local manybutton = wibox.widget {
	nil,
	{
		nil,
		{
			require "ui.sidebar.wifi", -- Return wifi
			require "ui.sidebar.bluetooth",
			require "ui.sidebar.sunlight",
			spacing = dpi(14),
			layout = wibox.layout.fixed.horizontal,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	expand = 'none',
	layout = wibox.layout.align.vertical,
}

local buttons = create_box(manybutton, beautiful.dark_blue)


sidebar : setup {
	{
		nil,
		{
			clock,
			separator,
			uptime_widget,
			volume_widget,
			bright_widget,
			buttons,
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	bg = beautiful.dark_blue,
	widget = wibox.container.background,
}
