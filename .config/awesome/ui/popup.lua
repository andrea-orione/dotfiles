local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

-- VAR {{{
local width = dpi(250)
local height = dpi(150)
-- }}}

-- STRUCTURE {{{
local icon = wibox.widget.textbox()
icon.font = beautiful.font_name .. " Regular 40"
icon.markup = ""

local name = wibox.widget.textbox()
icon.font = beautiful.font_name .. " Regular 12"
icon.markup = "Volume"

-- the progress bar
local progress =  wibox.widget.progressbar({
	margins = {top = dpi(6), bottom = dpi(6)},
	max_value = 100,
	min_value = 0,
	shape = gears.shape.rounded_bar,
	bar_shape = gears.shape.rounded_bar,
	background_color = beautiful.blue,
	color = beautiful.light_blue,
	bar_border_width = dpi(6)
})

-- the slider
local slider = wibox.widget.slider({
	shape = gears.shape.rounded_bar,
	bar_margins = {top = dpi(6), bottom = dpi(6)},
	maximum = 100,
	minimum = 0,
	value = 0,
	-- Sliderr
	bar_active_color = beautiful.light_blue,
	bar_color = beautiful.blue,
	bar_shape = gears.shape.rounded_bar,
	-- Handle
	handle_shape = gears.shape.circle,
	handle_border_width = dpi(2),
	handle_border_color = beautiful.blue,
	handle_color = beautiful.light_blue,
	handle_width = dpi(30)
})

-- slider's behavior (kinda)...
slider:connect_signal("property::value", function(_, newValue)
	awful.spawn.with_shell("pamixer -D pulse set Master " .. newValue .. "%")
end)
-- }}}


-- POPUP {{{
local popup = awful.popup {
	ontop = true,
	visible = false,
	placement = function(c)
		awful.placement.centered(c, {margins = {top = dpi(500)}})
	end,
	shape = function(cr,w,h)
		gears.shape.rounded_rect(cr,w,h,10)
	end,
	widget = wibox.container.margin,
}

-- It's widget/Setup
popup:setup {
	{
		{
			{
				icon,
				{
					name,
					progress,
					layout = wibox.layout.align.vertical,
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = {top = dpi(50), bottom = dpi(50), left = dpi(30), right = dpi(30)},
			widget = wibox.container.margin,
		},
		halign = 'center',
		valign = 'center',
		widget = wibox.container.place,
	},
	forced_height = height,
	forced_width = width,
	bg = beautiful.bar,
	widget = wibox.container.background,
}

local slide = rubato.timed {
	pos = 0,
	rate = 60,
	intro = 0.05,
	duration = 0.2,
	subscribed = function(pos)
		progress.value = pos
	end
}

-- Timeout
local timeout = gears.timer {
	timeout = 1,
	single_shot = true,
	autostart = false,
	call_now = false,
	callback = function()
		popup.visible = false
		slide.target = 0
	end
}

-- Connect to a signal "awesome/signals/volume"
local first_time = true
awesome.connect_signal("signal::volume", function(vol,mute)
	
	if first_time then
		first_time = false
	else
		popup.visible = true
		name.markup = "volume"
		progress.color = beautiful.blue

		if mute or vol == 0 then
			slide.target = 0
			icon.markup = ""
		else
			slide.target = vol
			if vol >= 75 then
				icon.markup = ""
			else
				icon.markup = ""
			end
		end

		if popup.visible then
			timeout:again()
		else
			timeout:start()
		end
	end
end)

-- Connect to a signal "awesome/signals/brightness"
local second_time = true
awesome.connect_signal("signal::brightness", function(bri)

	if second_time then
		second_time = false
	else
		popup.visible = true

		slide.target = bri
		progress.color = beautiful.yellow
		name.markup = "Brightness"
		icon.markup = ""

		if popup.visible then
			timeout:again()
		else
			timeout:start()
		end
	end
end)
-- }}}