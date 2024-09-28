--    ____     ____
--  /  __  \ /  __  \
-- |  |__|  |  |  |  |  Andrea Orione
-- |   __   |  |  |  |  https://www.github.com/andrea-orione
-- |  |  |  |  |__|  |
-- |__|  |__|\ ____ / 
--
--
-- Customization of Wezterm

local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- GENERAL VARIABLES
config.alternate_buffer_wheel_scroll_speed = 4
config.audible_bell = "Disabled"
config.automatically_reload_config = true
config.bold_brightens_ansi_colors = "No"
config.canonicalize_pasted_newlines = "None" -- Good options are "None", "LineFeed", "CarriageReturn"
config.cursor_blink_rate = 750
config.default_cursor_style = "BlinkingBar"
config.exit_behavior = "Close"
config.window_decorations = "NONE"
config.window_padding = {
    left = "0.4cell",
    right = 0,
    top = "0.5cell",
    bottom = 0,
}

-- COLOR AND APPEARENCE
local orion_color_schemes = require("Orion-themes")
config.color_schemes = orion_color_schemes

-- Cool color schemes are
--  - Shaman
--  - Orion Dark
--  - Orion Blue
--  - Dracula
config.color_scheme = 'Orion Dark'
config.enable_tab_bar = false
config.window_background_opacity = 1.0
-- config.window_background_image = "/path/to/wallpaper.jpg" -- Use custom wallpaper

-- FONT
config.font = wezterm.font('UbuntuMono Nerd Font')
config.font_size = 12
config.adjust_window_size_when_changing_font_size = false
config.allow_square_glyphs_to_overflow_width = "Always" -- default "WhenFollowedBySpace"
config.custom_block_glyphs = false
config.freetype_load_flags = 'NO_HINTING'

return config
