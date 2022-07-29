-- LIBRARY IMPORTATION {{{
local gears = require("gears") --Utilities such as color parsing and objects
local lain  = require("lain") --Layout, asyncronous widgets and utilities
local awful = require("awful") --Everything related to window parsing
local wibox = require("wibox") --Widjet and layout library
local beautiful = require("beautiful") --Theme handler

local os = os
local my_table = awful.util.table or gears.table --Binding tale 4.{0,1} compatibility

local markup = lain.util.markup
local separator =lain.util.separators
-- }}}


-- TEXTCLOCK{{{
os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock(markup("#eeeeee", "%A %d %B ") .. markup("#eeeeee", " %H:%M "))
mytextclock.font = beautiful.font
-- }}}

-- WEATHER {{{
-- The weather information are taken from
-- https://openweathermap.org
-- To change visit the site above and look for the corresponding id
-- local weathericon = wibox.widget.imagebox(beautiful.widget_weather)
-- beautiful.weather = lain.widget.weather({
--     city_id = 3165523, -- City id (Torino, IT)
--     notification_preset = { font = beautiful.popup_font, fg = beautiful.popup_fg, bg = beautiful.popup_bg },
--     weather_na_markup = markup.fontfg(beautiful.font, beautiful.fg_normal, "N/A "),
--     settings = function()
--         descr = weather_now["weather"][1]["description"]:lower()
--         units = math.floor(weather_now["main"]["temp"])
--         widget:set_markup(markup.fontfg(beautiful.font, beautiful.fg_normal, descr .. " @ " .. units .. "°C"))
--     end
-- })
-- }}}

-- FILESYSTEM INFO {{{
--local fsicon = wibox.widget.imagebox(beautiful.widget_fs)
--beautiful.fs = lain.widget.fs({
--    notification_preset = { font = "Noto Sans Mono Medium 10", fg = beautiful.fg_normal },
--    settings  = function()
--        widget:set_markup(markup.fontfg(beautiful.font, "#80d9d8", fs_now.used .. "% "))
--    end
--})
-- }}}

-- MAIL IMAP CHECK {{{
--[[ commented because it needs to be set before use
local mailicon = wibox.widget.imagebox()
beautiful.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(beautiful.widget_mail)
            widget:set_markup(markup.fontfg(beautiful.font, "#cccccc", mailcount .. " "))
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
-- }}}

-- CPU {{{
local cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, "#e33a6e", cpu_now.usage .. "% "))
    end 
})
-- }}}

-- CORE TEMPERATURE {{{
local tempicon = wibox.widget.imagebox(beautiful.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, "#f1af5f", coretemp_now .. "°C "))
    end
})
-- }}}

-- BATTERY {{{
local baticon = wibox.widget.imagebox(beautiful.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(beautiful.font, beautiful.fg_normal, perc .. " "))
    end
})
-- }}}

-- ALSA VOLUME {{{
local volicon = wibox.widget.imagebox(beautiful.widget_vol)
local volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(beautiful.font, "#7493d2", volume_now.level .. "% "))
    end
})
-- }}}

-- NETWORK {{{
-- local netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
-- local netdowninfo = wibox.widget.textbox()
-- local netupicon = wibox.widget.imagebox(beautiful.widget_netup)
-- local netupinfo = lain.widget.net({
--     settings = function()
--         if iface ~= "network off" and
--             string.match(beautiful.weather.widget.text, "N/A")
--         then
--             beautiful.weather.update()
--         end

--         widget:set_markup(markup.fontfg(beautiful.font, "#e54c62", net_now.sent .. " "))
--         netdowninfo:set_markup(markup.fontfg(beautiful.font, "#87af5f", net_now.received .. " "))
--     end
-- })
-- }}}

-- MEMORY {{{
local memicon = wibox.widget.imagebox(beautiful.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, "#e0da37", mem_now.used .. "M "))
    end
})
-- }}}
--[[
-- MUSIC PLAYER
local musicplr = "urxvt -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(beautiful.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    --awful.button({ }, 1, function ()
    --    awful.spawn.with_shell("mpc prev")
    --    beautiful.mpd.update()
    --end),
    --
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        beautiful.mpd.update()
    end),
    awful.button({ modkey }, 3, function () awful.spawn.with_shell("pkill ncmpcpp") end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc stop")
        beautiful.mpd.update()
    end)))
beautiful.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(beautiful.widget_music_on)
            widget:set_markup(markup.font(beautiful.font, markup("#FFFFFF", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(beautiful.font, " mpd paused "))
            mpdicon:set_image(beautiful.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(beautiful.widget_music)
        end
    end
})
--]]

function draw_bar_at_the_top(scr)
    -- Menu launcher
    local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = awful.util.mymainmenu })

    -- Tags
    awful.tag(awful.util.tagnames, scr, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    scr.mypromptbox = awful.widget.prompt()

    -- Keyboard map indicator and switcher
    scr.mykeyboardlayout = awful.widget.keyboardlayout()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    scr.mylayoutbox = awful.widget.layoutbox(scr)
    scr.mylayoutbox:buttons(my_table.join(
                        awful.button({ }, 1, function () awful.layout.inc( 1) end),
                        awful.button({ }, 3, function () awful.layout.inc(-1) end),
                        awful.button({ }, 5, function () awful.layout.inc( 1) end),
                        awful.button({ }, 4, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    scr.mytaglist = awful.widget.taglist(scr, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create the wibox
    scr.mywibox = awful.wibar({ position = "top", screen = scr, height = 20, bg = beautiful.bar_bg_normal, fg = beautiful.bar_fg_normal })

    -- Add widgets to the wibox
    scr.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand ="none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            scr.mytaglist,
            scr.mypromptbox,
        },
        -- Middle widgets
        mytextclock,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            scr.mykeyboardlayout,
            wibox.widget.systray(),
            --mailicon,
            --mail.widget,
            --mpdicon,
            --beautiful.mpd.widget,
            -- netdownicon,
            -- netdowninfo,
            -- netupicon,
            -- netupinfo.widget,
            volicon,
            volume.widget,
            memicon,
            memory.widget,
            cpuicon,
            cpu.widget,
            -- weathericon,
            -- beautiful.weather.widget,
            tempicon,
            temp.widget,
            baticon,
            bat.widget,
            scr.mylayoutbox,
        },
        
    }
end












-- For a remote future if you want a tasklist


--    s.mytasklist = awful.widget.tasklist {
--        screen = s,
--        filter = awful.widget.tasklist.filter.allscreen,
--        buttons =awful.util.tasklist_buttons,
--        style = {
--            shape = gears.shape.rounded_rect,
--        },
--        layout = {
--            spacing = 2,
--            forced_num_columns = 1,
--            layout = wibox.layout.grid.vertical
--        },
--        widget_template = {
--            {
--                {
--                    id = 'clienticon',
--                    widget = awful.widget.clienticon,
--                },
--                margins = 4,
--                widget = wibox.container.margin,
--            },
--            id = 'background_role',
--            forced_width =48,
--            forced_height = 48,
--            widget = wibox.container.background,
--            create_callback = function(self, c, index, objects) --luacheck: no unused
--                self:get_children_by_id('clienticon')[1].client = c
--            end,
--        },
--    }

--    awful.popup {
--        widget = s.mytasklist,
--        border_width = 0,
--        bg = '#000000',
--        opacity = 0, 
--        ontop = true,
--        placement =awful.placement.left,
--        shape = gears.shape.rounded_rect
--    }