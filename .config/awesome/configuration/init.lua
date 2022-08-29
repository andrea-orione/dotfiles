-- LIBRARY IMPORTATION {{{
local string = string

local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
local awful = require("awful")
local menubar = require("menubar")
-- }}}

-- VARIABLE DEFINITION {{{
-- Application variables
terminal = "alacritty"
browser = "firefox"
fileManager = "pcmanfm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
-- local emacs = "emacsclient -c -a 'emacs' "
-- local mediaplayer = some media player
-- local soundplayer = some sound player

awful.util.terminal = terminal
awful.util.tagnames = {"Dev", "Tex", "Www", "Doc", "Mus", "Set", "Ter", "Ot1", "Ot2", "Ot3"} -- Workspaces names 
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- THEME OPENING {{{
local theme_list = {
    "orion-blue", -- 1
}

local chosen_theme = theme_list[1] -- choose your theme here        
beautiful.init(string.format(gfs.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))
-- }}}

require("configuration.layout")
require("configuration.bindings")
require("configuration.client")
    
-- AUTOSTART APPLICATION {{{
local picom_startup_script = [[picom]] -- --config $HOME/.config/picom/picom.conf --experimental-backends

awful.spawn.with_shell(picom_startup_script)
--awful.spawn.with_shell("setxkbmap -layout it,us(dvorak)") -- Not working beacuse of the keybindings
awful.spawn.with_shell("setxkbmap -layout it")

-- }}}
