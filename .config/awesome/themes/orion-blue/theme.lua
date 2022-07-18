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
local lain  = require("lain") --Layout, asyncronous widgets and utilities
local awful = require("awful") --Everything related to window parsing
local wibox = require("wibox") --Widjet and layout library
local cairo = require("lgi").cairo --Wallpaper transition

local os = os
local my_table = awful.util.table or gears.table --Binding tale 4.{0,1} compatibility
-- }}}

-- VARIABLE DEFINITION {{{
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

local markup = lain.util.markup
local separator =lain.util.separators
-- }}}

-- TEXTCLOCK AND CALENDAR {{{
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(markup("#eeeeee", "%A %d %B ") .. markup("#eeeeee", " %H:%M "))
mytextclock.font = theme.font

theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.popup_font,
        fg   = theme.popup_fg,
        bg   = theme.popup_bg
    }
})
-- }}}

-- WEATHER {{{
-- The weather information are taken from
-- https://openweathermap.org
-- To change visit the site above and look for the corresponding id
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 3165523, -- City id (Torino, IT)
    notification_preset = { font = theme.popup_font, fg = theme.popup_fg, bg = theme.popup_bg },
    weather_na_markup = markup.fontfg(theme.font, theme.fg_normal, "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, descr .. " @ " .. units .. "°C"))
    end
})
-- }}}

-- / fs
--local fsicon = wibox.widget.imagebox(theme.widget_fs)
--theme.fs = lain.widget.fs({
--    notification_preset = { font = "Noto Sans Mono Medium 10", fg = theme.fg_normal },
--    settings  = function()
--        widget:set_markup(markup.fontfg(theme.font, "#80d9d8", fs_now.used .. "% "))
--    end
--})

-- Mail IMAP check
--[[ commented because it needs to be set before use
local mailicon = wibox.widget.imagebox()
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(theme.widget_mail)
            widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            --mailicon:set_image() -- not working in 4.0
            mailicon._private.image = nil
            mailicon:emit_signal("widget::redraw_needed")
            mailicon:emit_signal("widget::layout_changed")
        end
    end
})
--]]

-- CPU {{{
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
    end
})
-- }}}

-- CORE TEMPERATURE {{{
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
    end
})
-- }}}

-- BATTERY {{{
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
    end
})
-- }}}

-- ALSA VOLUME {{{
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, "#7493d2", volume_now.level .. "% "))
    end
})
-- }}}

-- NETWORK {{{
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
    settings = function()
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end

        widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
    end
})
-- }}}

-- MEMORY {{{
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
    end
})
-- }}}
--[[
-- MUSIC PLAYER
local musicplr = "urxvt -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    --awful.button({ }, 1, function ()
    --    awful.spawn.with_shell("mpc prev")
    --    theme.mpd.update()
    --end),
    --
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ modkey }, 3, function () awful.spawn.with_shell("pkill ncmpcpp") end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc stop")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FFFFFF", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})
--]]

-- DISPLAYING {{{
local function scanDir(directory)
    local c, fileList = 0, {}
    local pfiles = io.popen([[find "]] .. directory .. [[" -type f]])
    for fileName in pfiles:lines() do
        c = c + 1
        fileList[c] = fileName
    end
    return fileList
end

local function mix_surfaces(first, second, factor)
    local result = gears.surface.duplicate_surface(first)
    local cr = cairo.Context(result)
    cr:set_source_surface(second, 0, 0)
    cr:paint_with_alpha(factor)
    return result
end

local function fade_to_wallpaper(new_wp, steps, interval, screen)
    new_wp = gears.surface(new_wp)
    local old_wp = gears.surface(root.wallpaper())
    if not old_wp then
        callback(new_wp)
        return
    end
    old_wp = gears.surface.duplicate_surface(old_wp)
    local steps_done = 0
    gears.timer.start_new(interval, function()
        steps_done = steps_done + 1
        local mix = mix_surfaces(old_wp, new_wp, steps_done / steps)
        gears.wallpaper.maximized(mix, screen, true)
        mix:finish()
        return steps_done <= steps
    end)
end

-- Main function
function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })
    -- s.quake = lain.util.quake({ app = "termite", height = 0.50, argname = "--name %s" })

    -- Wallpaper
    math.randomseed(os.time())
    wallpaperList = scanDir(theme.wallpapers_folder)
    gears.wallpaper.maximized(wallpaperList[math.random(1, #wallpaperList)], s, true)
    changing_time = 1800
    wallpaper_timer = gears.timer{
        timeout = changing_time,
        call_now = true,
        autostart = true,
        callback = function()
            fade_to_wallpaper(wallpaperList[math.random(1, #wallpaperList)], 90, 1/30, s)
        end
    }

    -- Menu launcher
    mylauncher = awful.widget.launcher({ image = theme.awesome_icon,
    menu = awful.util.mymainmenu })

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Keyboard map indicator and switcher
    s.mykeyboardlayout = awful.widget.keyboardlayout()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 5, function () awful.layout.inc( 1) end),
                           awful.button({ }, 4, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 20, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand ="none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            --s.mypromptbox,
        },
        -- Middle widgets
        mytextclock,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.mykeyboardlayout,
            wibox.widget.systray(),
            --mailicon,
            --mail.widget,
            mpdicon,
            --theme.mpd.widget,
            netdownicon,
            netdowninfo,
            netupicon,
            netupinfo.widget,
            volicon,
            theme.volume.widget,
            memicon,
            memory.widget,
            cpuicon,
            cpu.widget,
            weathericon,
            theme.weather.widget,
            tempicon,
            temp.widget,
            baticon,
            bat.widget,
            s.mylayoutbox,
        },
        
    }

    -- Create the bottom wibox
    -- s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = 20, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the bottom wibox
    --s.mybottomwibox:setup {
    --    layout = wibox.layout.align.horizontal,
    --    { -- Left widgets
    --        layout = wibox.layout.fixed.horizontal,
    --    },
    --    s.mytasklist, -- Middle widget
    --    { -- Right widgets
    --        layout = wibox.layout.fixed.horizontal,
    --        s.mylayoutbox,
    --    },
    --}

    -- Create a tasklist popup
    awful.popup {
        widget = awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.allscreen,
            buttons =awful.util.tasklist_buttons,
            style = {
                shape = gears.shape.rounded_rect,
            },
            layout = {
                spacing = 5,
                forced_num_columns = 1,
                layout = wibox.layout.grid.vertical
            },
            widget_template = {
                {
                    {
                        id = 'clienticon',
                        widget = awful.widget.clienticon,
                    },
                    margins = 4,
                    widget = wibox.container.margin,
                },
                id = 'background_role',
                forced_width =48,
                forced_height = 48,
                widget = wibox.container.background,
                create_callback = function(self, c, index, objects) --luacheck: no unused
                    self:get_children_by_id('clienticon')[1].client = c
                end,
            },
        },
        border_color = '#777777',
        border_width = 2,
        ontop = true,
        placement =awful.placement.left,
        shape = gears.shape.rounded_rect
    }


end
-- }}}

return theme

