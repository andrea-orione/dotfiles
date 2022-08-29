local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local io, os, string, tostring, tonumber = io, os, string, tostring, tonumber

local dpi = beautiful.xresources.apply_dpi
local my_table = awful.util.table or gears.table -- bindings table 4.{0,1} compatibility

-- SETUP {{{
local box_gap = dpi(10)
local border_radius = dpi(10)

local dashboard = wibox {
	visible = false,
	ontop = true,
	bg = beautiful.black .. "aa",
	type = 'dock'
}

awful.placement.maximize(dashboard)

local keylock = awful.keygrabber {
	autostart = false,
	stop_event = 'release',
	keypressed_callback = function(self, mod, key, command)
		if key == "Escape" then
			awesome.emit_signal("dashboard::toggle")
		end
	end
}

local toggle = function()
	if dashboard.visible then
		keylock:stop()
	else
		keylock:start()
	end
	dashboard.visible = not dashboard.visible
end

dashboard:buttons(my_table.join(
	awful.button({ }, 1, function()
		toggle()
	end),
	awful.button({ }, 3, function()
		toggle()
	end)
))

awesome.connect_signal("dashboard::toggle", function()
	toggle()
end)
-- }}}

-- FUCNTIONS {{{
-- Rounded Rectangle
local function rr(cr,w,h)
	gears.shape.rounded_rect(cr,w,h,border_radius)
end

-- Vertical padding
local function v_pad(pad)
	local v_padding = wibox.layout.fixed.horizontal()
	v_padding.forced_height = dpi(pad)

	return v_padding
end

-- Coloring
local function coloring_text(text, color)
	color = color or beautiful.white
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

-- Create box function
local function create_box(widget, width, height, bg)
	local box_h_layout = wibox.layout.align.horizontal(nil, widget)
	box_h_layout.expand = "none"
	local box_v_layout = wibox.layout.align.vertical(nil, box_h_layout)
	box_v_layout.expand = "none"

	local container = wibox.container.background(box_v_layout, bg, rr)
	container.forced_width = width
	container.forced_height = height
	container.border_width = dpi(4)
	container.border_color = beautiful.light_blue

	local box_widget = wibox.container.margin(container)
	box_widget.margins = box_gap

	return box_widget
end
-- }}}

-- VARIABLES {{{
-- Profile Widget
local user_image = wibox.widget.imagebox(beautiful.user_pic)
user_image.halign = "center"
local user_picture = wibox.container.background(user_image)
user_picture.forced_width = dpi(200)
user_picture.forced_height = dpi(200)
user_picture.shape = gears.shape.circle

local user_widget = wibox.widget.textbox()
user_widget.font = beautiful.font_name .. " Bold 38"
user_widget.align = "center"
user_widget.markup = coloring_text(os.getenv('USER'), beautiful.green)

local description_widget = wibox.widget.textbox(beautiful.user_description)
description_widget.font = beautiful.font_name .. " Regular 16"
description_widget.align = "center"

local profile_v_layout = wibox.layout.fixed.vertical(user_picture, v_pad(20), user_widget, description_widget)
profile_v_layout.spacing = dpi(20)

local profile_h_layout = wibox.layout.align.horizontal(nil, profile_v_layout)
profile_h_layout.expand = "none"

local profile_widget = wibox.container.margin(profile_h_layout)
profile_widget.margins = dpi(12)

local profile = create_box(profile_widget, 360, 460, beautiful.dark_blue)

-- Clock Widget
local clock_widget = wibox.widget.textclock("%H:%M", 60)
clock_widget.font = beautiful.font_name .. " Bold 42"

local clock = create_box(clock_widget, 360, 200, beautiful.dark_blue)

-- Calendar
local styles = {}
styles.month = { 
	padding = dpi(20),
	fg_color = beautiful.blue,
	bg_color = beautiful.transparent,
	border_width = dpi(0)
}
styles.normal = { shape = rr }
styles.focus = { 
	fg_color = beautiful.orange,
	bg_color = beautiful.transparent,
	markup = function(t) return '<b>' .. t .. '</b>' end 
}
styles.header = {
	fg_color = beautiful.red,
	markup = function(t) return '<span font_desc="' .. beautiful.font_name .. ' Bold 20">' ..  t .. '</span>' end
}
styles.weekday = {
	fg_color = beautiful.blue,
	bg_color = beautiful.transparent,
	padding = dpi(3),
	markup   = function(t) return '<b>' .. t .. '</b>' end
}

local function decorate_cell(widget, flag, date)
    if flag=="monthheader" and not styles.monthheader then
        flag = "header"
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
    local weekday = tonumber(os.date("%w", os.time(d)))
    local default_bg = beautiful.transparent
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape        = props.shape,
        border_color = props.border_color or beautiful.blue,
        border_width = props.border_width or 0,
        fg           = props.fg_color or "#999999",
        bg           = props.bg_color or default_bg,
        widget       = wibox.container.background
    }

    return ret
end

local calendar_widget = wibox.widget.calendar.month(os.date('*t'), beautiful.font_name .. " Regular 16")
calendar_widget.spacing = dpi(10)
calendar_widget.fn_embed = decorate_cell

local calendar = create_box(calendar_widget, 300, 400, beautiful.dark_blue)

-- Uptime
local uptime_text = wibox.widget.textbox()
uptime_text.font = beautiful.font_name .. " Regular 16"
uptime_text.align = "center"
local uptime_icon = wibox.widget.textbox()
uptime_icon.font = beautiful.font_name .. " Regular 42"
uptime_icon.align = 'center'
uptime_icon.markup = coloring_text("", beautiful.blue)

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		local script = io.popen('uptime -p')
		local upfor = tostring(script:read('*a'))
		upfor = string.gsub(upfor, '\n', '')
		uptime_text.markup = coloring_text(upfor)
	end
}

local uptime_widget = wibox.layout.fixed.vertical(uptime_icon, uptime_text)
uptime_widget.spacing = dpi(10)

local uptime = create_box(uptime_widget, 400, 140, beautiful.dark_blue)

-- Stats
local volume_icon = wibox.widget.textbox()
local bright_icon = wibox.widget.textbox()

volume_icon.font = beautiful.font_name .. " Regular 42"
bright_icon.font = beautiful.font_name .. " Regular 42"

volume_icon.markup = coloring_text("", beautiful.blue)
bright_icon.markup = coloring_text("", beautiful.orange)

local volume_progressbar = wibox.widget.progressbar()
volume_progressbar.max_value = 100
volume_progressbar.color = beautiful.blue
volume_progressbar.background_color = beautiful.white .. "40"
volume_progressbar.shape = gears.shape.rounded_bar
volume_progressbar.bar_shape = gears.shape.rounded_bar
local volume_slider = wibox.container.rotate(volume_progressbar, "east")
volume_slider.forced_width = dpi(5)
volume_slider.forced_height = dpi(150)
awesome.connect_signal("signal::volume", function(value, muted)
	if muted then
		volume_icon.markup = coloring_text("", beautiful.blue)
		volume_progressbar.value = 0
		return
	end
	if value >= 60 then
		volume_icon.markup = coloring_text("", beautiful.blue)
	elseif value < 30 then
		volume_icon.markup = coloring_text("", beautiful.blue)
	else
		volume_icon.markup = coloring_text("", beautiful.blue)
	end
	volume_progressbar.value = value
end)

local bright_progressbar = wibox.widget.progressbar()
bright_progressbar.max_value = 80
bright_progressbar.color = beautiful.orange
bright_progressbar.background_color = beautiful.white .. "40"
bright_progressbar.shape = gears.shape.rounded_bar
bright_progressbar.bar_shape = gears.shape.rounded_bar
local bright_slider = wibox.container.rotate(bright_progressbar, "east")
bright_slider.forced_width = dpi(5)
bright_slider.forced_height = dpi(150)
awesome.connect_signal("signal::brightness", function(value,_)
	bright_progressbar.value = value
end)

volume_slider:buttons(gears.table.join(
	awful.button({ }, 4, function()
		awful.spawn.with_shell("pamixer -i 5")
	end),
	awful.button({ }, 5, function()
		awful.spawn.with_shell("pamixer -d 5")
	end)
))

bright_slider:buttons(gears.table.join(
	awful.button({ }, 4, function()
		awful.spawn.with_shell("brightnessctl set +4%")
	end),
	awful.button({ }, 5, function()
		awful.spawn.with_shell("brightnessctl set 4%-")
	end)
))

local volume_container = wibox.container.margin(volume_slider)
volume_container.margins = {left = dpi(20), right = dpi(20)}
local volume_v_layout = wibox.layout.fixed.vertical(volume_container)
volume_v_layout.spacing = dpi(10)

local bright_container = wibox.container.margin(bright_slider)
bright_container.margins = {left = dpi(20), right = dpi(20)}
local bright_v_layout = wibox.layout.fixed.vertical(bright_container)
bright_v_layout.spacing = dpi(10)

local stats_widget = wibox.layout.fixed.horizontal(volume_v_layout, bright_v_layout)
stats_widget.spacing = dpi(20)

local stats = create_box(stats_widget, 200, 300, beautiful.dark_blue)

-- Disk
local disk_text = wibox.widget.textbox()
disk_text.font = beautiful.font_name .. " Regular 46"
disk_text.markup = coloring_text("󰋊", beautiful.white .. "40")
disk_text.align = 'center'
disk_text.valign = 'center'

local disk_progressbar = wibox.widget.progressbar()
disk_progressbar.color = beautiful.red
disk_progressbar.background_color = beautiful.transparent
disk_progressbar.shape = rr
local disk_bar = wibox.container.rotate(disk_progressbar, "east")

local function get_disk()
	script = [[
	df -kH -B 1MB /dev/sda2 | tail -1 | awk '{printf "%d|%d" ,$2, $3}'
	]]
	awful.spawn.easy_async_with_shell(script, function(stdout)
		local disk_total = stdout:match('(%d+)[|]')
		disk_total = disk_total / 1000
		local disk_available = stdout:match('%d+[|](%d+)')
		disk_available = disk_available / 1000

		awesome.emit_signal("signal::disk", disk_total, disk_available)
	end)
end

gears.timer {
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		get_disk()
	end
}

awesome.connect_signal("signal::disk", function(disk_total, disk_available)
	disk_progressbar.value = disk_available
	disk_progressbar.max_value = disk_total
end)

local disk_v_layout = wibox.layout.align.vertical(nil, disk_text)
disk_v_layout.expand = "none"
local disk_widget = wibox.layout.stack()
disk_widget:add(disk_bar)
disk_widget:add(disk_v_layout)

local disk = create_box(disk_widget, 100, 300, beautiful.dark_blue)

-- Weather
local temperature = wibox.widget.textbox()
temperature.font = beautiful.font_name .. " Bold 20"
temperature.align = "center"

local how = wibox.widget.textbox() -- How's-the-weather widget
how.font = beautiful.font_name .. " Regular 18"
how.align = "center"

local weather_icon = wibox.widget.textbox()
weather_icon.font = beautiful.font_name .. " Regualr 72"
weather_icon.align = "center"

awesome.connect_signal('signal::weather', function(temp, icon, what)
	temperature.markup = coloring_text(temp .. "󰔄", beautiful.orange)
	how.markup = coloring_text(what, beautiful.white)
	weather_icon.markup = coloring_text(icon, beautiful.white)
end)

local weather_container = wibox.container.constraint(how, "max")
weather_container.width = dpi(200)
local weather_v_layout = wibox.layout.fixed.vertical(temperature, weather_container)
local weather_widget = wibox.layout.fixed.horizontal(weather_icon, weather_v_layout)
weather_widget.spacing = dpi(10)

local weather = create_box(weather_widget, 300, 300, beautiful.dark_blue)
-- }}}

-- PLACING {{{
local left = wibox.layout.fixed.vertical(profile, uptime)
local middle = wibox.layout.fixed.vertical(clock, calendar)
local sliders = wibox.layout.fixed.horizontal(stats, disk)
local right = wibox.layout.fixed.vertical(weather, sliders)

dashboard : setup {
	nil,
	{
		nil,
		{
			left,
			middle,
			right,
			spacing = dpi(10),
			layout = wibox.layout.fixed.horizontal,
		}, 
		expand = 'none',
		layout = wibox.layout.align.vertical,
	},
	expand = 'none',
	layout = wibox.layout.align.horizontal,
}
-- }}}