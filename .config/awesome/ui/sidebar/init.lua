local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")

local markup = lain.util.markup

-- TODO Add this library or make yours
-- local rubato = require("lib.rubato")

local scr = awful.screen.focused()

-- FUNCTIONS {{{
local function round_rec(widg, width, height)
    gears.shape.rounded_rect(widg, width, height, 5)
end

local function partial_round_rec(widg, width, height)
    gears.shape.partially_rounded_rect(widg, width, height, false, true, false, false, 32)
end

local function crt_box(widget, bg_color, border_width)
	-- local container = wibox.container.background()
	-- --container.forced_width = width
	-- --container.forced_height = height
	-- container.border_width = border_width or 0
	-- container.border_color = beautiful.bar_alt
	-- container.bg = bg_color or beautiful.transparent
	-- container.shape = rr

	local box_widget = wibox.container.margin {
		wibox.container.background {
			{
				nil,
				{
					nil,
					widget,
					expand = 'none',
					layout = wibox.layout.align.vertical,
				},
				expand = 'none',
				layout = wibox.layout.align.horizontal,
			},
			border_width = border_width or 0,
	        border_color = beautiful.bar_alt,
	        bg = bg_color or beautiful.transparent,
	        shape = rr
		},
		margins = 10,
	}

	return box_widget
end
-- }}}

-- SIDEBAR {{{
sidebar = wibox {
    visible = true,
    ontop = true,
    width = beautiful.sidebar_width,
    height = beautiful.sidebar_height,
    border_width = beautiful.sidebar_border,
    border_color = beautiful.light_blue,
    bg = beautiful.blue,
    shape = round_rec,
    type = 'dock'
}

awful.placement.left(sidebar, {margins = {top = 90}})

-- local slide = rubato.timed {
--     pos = scr.geometry.x - sidebar.width,
--     rate = 60,
--     intro = 0.2,
--     duration = 0.4,
--     subscribed = function(pos)
--         sidebar.x = scr.geometry.x + gaps + pos
--     end
-- }

local timer = gears.timer {
    timeout = 0.4,
    call_now = true,
    single_shot = true,
    callback = function()
        sidebar.visible = not sidebar.visible
    end
}

local function toggle()
    if sidebar.visible then
        -- slide.target = scr.geometry.x - sidebar.width -- x = 0 - sidebar's width
		timer:start()
	else
		-- slide.target = scr.geometry.x -- x = 0
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
time.align = "center"
local date = wibox.widget.textclock(markup(beautiful.white, "%a %d %b %Y"))
date.font = beautiful.font_name .. "Medium 14"
date.align = "center"

local clock = wibox.container.margin{
    {
        time,
        date,
        layout = wibox.layout.fixed.vertical,
    }, 
    left=12,
    right=12,
    top=10,
    bottom=10,
}

-- Separator
local separtator = wibox.container.margin{
    wibox.container.background{
        forced_height = 5,
        bg = beautiful.blue,
    },
    bottom = 20,
}

-- Uptime
local uptime_widget = wibox.widget.textbox()
uptime_widget.font = beautiful.font_name .. " Medium 14"
uptime_widget.align = 'center'

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
	awful.spawn.easy_async_with_shell('uptime -p', function(stdout)
		uptime_widget.markup = markup(beautiful.white, stdout)
	end)
end
}

-- Volume and Brightness
local icon = {
	["volume"] = {icon = "󰋋", color = beautiful.blue},
	["bright"] = {icon = "󰃟", color = beautiful.yellow},
}

local crt_icon = function(text, color)
	local icon_widget = wibox.widget.textbox()
	icon_widget.font = beautiful.font_name .. " 22"
	icon_widget.align = 'center'
	icon_widget.markup = coloring_text(text, color)

	return icon_widget
end

local volume_icon = crt_icon(icon["volume"].icon, icon["volume"].color)
local bright_icon = crt_icon(icon["bright"].icon, icon["bright"].color)

local crt_slider = function(color)
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

local get_volume = function()
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
      		local value = string.gsub(stdout, "^%s*(.-)%s*$", "%1")
       		volume_slider.value = tonumber(value)
	end)
end

local get_brightness = function()
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

local buttons = crt_box(manybutton, beautiful.bar)
-- }}}

-- PLACING {{{
sidebar : setup {
    wibox.container.background {
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
}

-- }}}