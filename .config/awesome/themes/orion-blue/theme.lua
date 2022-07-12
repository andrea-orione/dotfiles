--    ____     ____
--  /  __  \ /  __  \
-- |  |__|  |  |  |  |  Andrea Orione
-- |   __   |  |  |  |  https://www.github.com/andrea-orione
-- |  |  |  |  |__|  |
-- |__|  |__|\ ____ /
--
--
-- Orion blue theme for awesome wm

-- LIBRARY IMPORTATION {{{
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window parsing
local wibox = require("wibox") --Widget and layout library
-- }}}

local os = os
local my_table = awful.util.table or gears.table --bindings table 4.{0,1} compatibility

-- VARIABLE DEFINITION {{{
local theme                     = {}
theme.confdir                   = os.getenv("HOME") .. "/.config/awesome/themes/orion-blue"
theme.wallpaper_folder          = os.getenv("HOME") .. ".wallpapers"
-- TODO change to ubuntu font
theme.font                      = "Noto Sans Regular 11"
theme.taglist_font              = "Noto Sans Regular 13"
theme.menu_bg_normal            = "#000000"
theme.menu_bg_focus             = "#000000"
theme.bg_normal                 = "#000000"
theme.bg_urgent                 = "#000000"
theme.fg_normal                 = "#aaaaaa"
theme.fg_focus                  = "#ff8c00"
theme.fg_urgent                 = "#af1d18"
theme.fg_minimize               = "#ffffff"
theme.border_width              = 2
theme.border_normal             = "#1c2022"
theme.border_focus              = "#606060"
theme.border_marked             = "#3ca4d8"
theme.menu_border_width         = 0
theme.menu_width                = 140
theme.menu_submenu_icon         = theme.confdir .. "/icon/submenu.png"
