local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local menubar = require("menubar")
local beautiful = require("beautiful")
local naughty = require("naughty")

local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.ontop = true
naughty.config.defaults.position = "top_right"
naughty.config.defaults.title = "System"
naughty.config.defaults.timeout = 3

naughty.config.presets.low.timeout      = 3
naughty.config.presets.critical.timeout = 0

-- naughty normal preset
naughty.config.presets.normal = {
    font    = beautiful.font,
    fg      = beautiful.white,
    bg      = beautiful.light_blue
}

-- naughty low preset
naughty.config.presets.low = {
    font = beautiful.font_name .. "10",
    fg = beautiful.white,
    bg = beautiful.light_blue
}

-- naughty critical preset
naughty.config.presets.critical = {
    font = beautiful.font_name .. "12",
    fg = beautiful.white,
    bg = beautiful.red,
    timeout = 0
}


-- apply preset
naughty.config.presets.ok   =   naughty.config.presets.normal
naughty.config.presets.info =   naughty.config.presets.normal
naughty.config.presets.warn =   naughty.config.presets.critical

