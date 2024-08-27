-- LIBRARY IMPORTATION
local string = string

local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
local awful = require("awful")
local menubar = require("menubar")

-- VARIABLE DEFINITION
-- Application variables
terminal = "alacritty"
browser = "firefox"
fileManager = "thunar"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
-- local mediaplayer = some media player
-- local soundplayer = some sound player

awful.util.terminal = terminal
awful.util.tagnames = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"} -- Workspaces names 

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- THEME OPENING
local theme_list = {
    "orion-blue", -- 1
}

local chosen_theme = theme_list[1] -- choose your theme here        
beautiful.init(string.format(gfs.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.corner.se,
}
require("configuration.bindings")
require("configuration.client")

-- AUTOSTART APPLICATION {{{
-- awful.spawn.with_shell("setxkbmap -layout it,us(dvorak)") -- Not working beacuse of the keybindings
-- awful.spawn.with_shell("setxkbmap -layout it")

-- }}}
