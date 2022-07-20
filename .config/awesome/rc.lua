--    ____     ____
--  /  __  \ /  __  \
-- |  |__|  |  |  |  |  Andrea Orione
-- |   __   |  |  |  |  https://www.github.com/andrea-orione
-- |  |  |  |  |__|  |
-- |__|  |__|\ ____ /
--
--
-- Configuration for awesome wm

-- LIBRARY IMPORTATION {{{
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window parsing
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults['icon_size'] = 50

local freedesktop = require("freedesktop")
local lain = require("lain")

-- Menubar
local menubar = require("menubar")

-- Hotkeys widjet
-- Enable hotkeys help widget for VIM and other apps when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- bindings table 4.{0,1} compatibility

--require "signals"
require "configuration"
--require "ui"
-- }}}


-- ERROR HANDLING {{{
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- MENU {{{
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "Manual", terminal .. " -e man awesome" },
   { "Edit config", editor_cmd .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
}

awful.util.mymainmenu = freedesktop.menu.build({
	icon_size = beautiful.menu_height or 16,
	before = { 
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
	},
	after = {
        { "Terminal", terminal },
		{ "Log out", function() awesome.quit() end },
		{ "Sleep", "systemctl suspend" },
		{ "Reboot", "systemctl reboot" },
		{ "Shutdown", "systemctl poweroff" }
    }
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

local function set_wallpaper(wallpaper, s)
   gears.wallpaper.maximized(wallpaper, s, true)
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- TODO change this to match the modifications
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

    -- Add widgets to the wibox
    --s.mywibox:setup {
    --    layout = wibox.layout.align.horizontal,
    --    { -- Left widgets
    --        layout = wibox.layout.fixed.horizontal,
    --        mylauncher,
    --        s.mytaglist,
    --        s.mypromptbox,
    --    },
    --    s.mytasklist, -- Middle widget
    --    { -- Right widgets
    --        layout = wibox.layout.fixed.horizontal,
    --        mykeyboardlayout,
    --        wibox.widget.systray(),
    --        mytextclock,
    --        s.mylayoutbox,
    --    },
    --}
--end)

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
