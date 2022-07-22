--    ____     ____
--  /  __  \ /  __  \
-- |  |__|  |  |  |  |  Andrea Orione
-- |   __   |  |  |  |  https://www.github.com/andrea-orione
-- |  |  |  |  |__|  |
-- |__|  |__|\ ____ /
--
--
-- Orion blue theme for awesome wm

local os = os

local theme                                     = {}

-- Folders
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/orion-blue"
theme.wallpapers_folder                         = os.getenv("HOME") .. "/.wallpapers"

-- Fonts
theme.font                                      = "Ubuntu Regular 11"
theme.taglist_font                              = "Ubuntu Regular 11"

-- Menu
theme.awesome_icon                              = theme.confdir .. "/icons/awesome/awesome32.png"
theme.icon_size                                 = 16
theme.menu_bg_normal                            = "#000000a0"
theme.menu_bg_focus                             = "#7aeeff20"
theme.menu_border_width                         = 2
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#eeeeee"
theme.menu_fg_focus                             = "#00e1ff"

-- Bars
theme.bg_normal                                 = "#0000006e"
theme.bg_focus                                  = "#00000000"
theme.bg_urgent                                 = "#00000000"
theme.fg_normal                                 = "#eeeeee"
theme.fg_focus                                  = "#00e1ff"--"#ff8c00"
theme.fg_urgent                                 = "#af1d18"
theme.fg_minimize                               = "#eeeeee"

-- Clients
theme.border_width                              = 2
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#00e1ff"
theme.border_marked                             = "#3ca4d8"
theme.useless_gap                               = 6

-- Popups
theme.popup_font                                = "Ubuntu regular 11"
theme.popup_bg                                  = "#000000dd"
theme.popup_fg                                  = "#eeeeee"

-- Topbar icons
theme.widget_temp                               = theme.confdir .. "/icons/thermometer.svg"
theme.widget_uptime                             = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                                = theme.confdir .. "/icons/cpu.svg"
theme.widget_weather                            = theme.confdir .. "/icons/weather/weather-few-clouds.svg"
theme.widget_fs                                 = theme.confdir .. "/icons/fs.png"
theme.widget_mem                                = theme.confdir .. "/icons/memory.svg"
theme.widget_netdown                            = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                              = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                               = theme.confdir .. "/icons/mail.png"
theme.widget_batt                               = theme.confdir .. "/icons/battery/battery-100.svg"
theme.widget_clock                              = theme.confdir .. "/icons/clock.svg"
theme.widget_vol                                = theme.confdir .. "/icons/audio/volume-high.svg"
theme.widget_music                              = theme.confdir .. "/icons/music.svg"
theme.widget_music_on                           = theme.confdir .. "/icons/note.png"
theme.widget_music_pause                        = theme.confdir .. "/icons/pause.svg"
theme.widget_music_stop                         = theme.confdir .. "/icons/stop.png"
theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"

-- Layout icons
theme.layout_tile                               = theme.confdir .. "/icons/layout/tilew.png"
--theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
--theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/layout/tilebottomw.png"
--theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
--theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
--theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
--theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
--theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/layout/maxw.png"
--theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
--theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/layout/floatingw.png"

-- Titlebar icons
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

return theme