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

-- User
theme.user_description                          = "Description"
theme.user_pic                                  = theme.confdir .. "/icons/profile_pic.jpg"

-- Fonts
theme.font_name                                 = "Ubuntu"
theme.font                                      = "Ubuntu Regular 11"
theme.taglist_font                              = "Ubuntu Regular 11"

-- Colors 
theme.white                                     = "#eeeeee"
theme.black                                     = "#000000"
theme.light_blue                                = "#00e1ff"
theme.dark_blue                                 = "#000e60"
theme.blue                                      = "#84a0c6"
theme.yellow                                    = "#ffef00"
theme.green                                     = "#00b70a"
theme.red                                       = "#e27878"
theme.orange                                    = "#fea400"
theme.transparent                               = "#00000000"

-- Menu
theme.awesome_icon                              = theme.confdir .. "/icons/awesome/awesome32.png"
theme.icon_size                                 = 16
theme.menu_bg_normal                            = theme.black .. "a0"
theme.menu_bg_focus                             = "#7aeeff20"
theme.menu_border_width                         = 2
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = theme.white
theme.menu_fg_focus                             = theme.light_blue

-- Bars
theme.bar_bg_normal                             = theme.black .. "6e"
theme.bar_fg_normal                             = theme.white

-- Taglist
theme.taglist_bg_normal                         = theme.black .. "6e"
theme.taglist_bg_focus                          = theme.transparent
theme.taglist_bg_urgent                         = theme.transparent
theme.taglist_fg_normal                         = theme.white
theme.taglist_fg_focus                          = theme.light_blue--"#ff8c00"
theme.taglist_fg_urgent                         = "#af1d18"
theme.taglist_fg_minimize                       = theme.white

-- Clients
theme.border_width                              = 2
theme.border_normal                             = theme.transparent
theme.border_focus                              = theme.light_blue
theme.border_marked                             = "#3ca4d8"
theme.useless_gap                               = 6

-- Sidebar
theme.sidebar_border                            = 2
theme.sidebar_width                             = 320 -- The border is not included
theme.sidebar_hight                             = 400 -- The border is not included
theme.sidebar_gaps                              = 20

-- Popups
theme.popup_font                                = theme.font
theme.popup_bg                                  = theme.black .. "dd"
theme.popup_fg                                  = theme.white

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
theme.layout_fullscreen                         = theme.confdir .. "/icons/layout/fullscreenw.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/layout/magnifierw.png"
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