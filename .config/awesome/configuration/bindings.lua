-- LIBRARY IMPORTATION {{{
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local lain = require("lain")

local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

local my_table = awful.util.table or gears.table -- bindings table 4.{0,1} compatibility
-- }}}

local modkey = "Mod4" --Window key
local altkey = "Mod1" --Alt
local ctrlkey = "Control"

-- KEYBINDINGS {{{
globalkeys = my_table.join(
-- Awesome keybindings
    awful.key({modkey }, "s", hotkeys_popup.show_help, {description="Show help", group="Awesome"}),
    awful.key({modkey }, "w", function()
            awful.util.mymainmenu:show()
        end,
        {description = "Show main menu", group = "Awesome"}),
    awful.key({ modkey, ctrlkey }, "r", awesome.restart, {description = "Reload awesome", group = "Awesome"}),
--  awful.key({ modkey, "Shift" }, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "x", function()
            awful.prompt.run {
            prompt       = "Run Lua code: ",
            textbox      = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "Lua execute prompt", group = "Awesome"}),

-- Launcher
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end, {description = "Open a terminal", group = "Launcher"}),
    awful.key({ modkey }, "b", function() awful.spawn(browser) end, {description = "Open a browser", group = "Launcher"}),
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end, {description = "Run prompt", group = "Launcher"}),
    awful.key({ modkey }, "p", function() menubar.show() end, {description = "Show the menubar", group = "Launcher"}),

-- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev, {description = "View previous", group = "Tag"}),
    awful.key({ modkey }, "Right",  awful.tag.viewnext, {description = "View next", group = "Tag"}),
    awful.key({ modkey }, "Escape", awful.tag.history.restore, {description = "Go back", group = "Tag"}),
-- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end, {description = "Add new tag", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end, {description = "Rename tag", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end, {description = "Move tag to the left", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end, {description = "Move tag to the right", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end, {description = "Delete tag", group = "Tag"}),


-- Client focus
    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end, {description = "Focus next by index", group = "Client"}),
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end, {description = "Focus previous by index", group = "Client"}),
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end, {description = "Swap with next client by index", group = "Client"}),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, {description = "Jump to urgent client", group = "Client"}),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end, {description = "Swap with previous client by index", group = "Client"}),
    awful.key({ modkey }, "Tab", function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "Go back", group = "Client"}),
    awful.key({ modkey, ctrlkey }, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,
        {description = "Restore minimized", group = "Client"}),

-- Screen focus
    awful.key({ modkey, ctrlkey }, "j", function() awful.screen.focus_relative(1) end, {description = "Focus the next screen", group = "Screen"}),
    awful.key({ modkey, ctrlkey }, "k", function() awful.screen.focus_relative(-1) end, {description = "Focus the previous screen", group = "Screen"}),

-- Layout
    awful.key({ modkey,           }, "l",     function() awful.tag.incmwfact( 0.05)          end,
              {description = "Increase master width factor", group = "Layout"}),
    awful.key({ modkey,           }, "h",     function() awful.tag.incmwfact(-0.05)          end,
              {description = "Decrease master width factor", group = "Layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function() awful.tag.incnmaster( 1, nil, true) end,
              {description = "Increase the number of master clients", group = "Layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function() awful.tag.incnmaster(-1, nil, true) end,
              {description = "Decrease the number of master clients", group = "Layout"}),
    awful.key({ modkey, ctrlkey   }, "h",     function() awful.tag.incncol( 1, nil, true)    end,
              {description = "Increase the number of columns", group = "Layout"}),
    awful.key({ modkey, ctrlkey   }, "l",     function() awful.tag.incncol(-1, nil, true)    end,
              {description = "Decrease the number of columns", group = "Layout"}),
    awful.key({ modkey,           }, "space", function() awful.layout.inc( 1)                end,
              {description = "Select next", group = "Layout"}),
    awful.key({ modkey, "Shift"   }, "space", function() awful.layout.inc(-1)                end,
              {description = "Select previous", group = "Layout"}),

-- Volume
    -- awful.key({ }, "XF86AudioRaiseVolume", function() awful.spawn.with_shell("pamixer -i 3") end, {description = "Raise volume", group = "Volume"}),
    -- awful.key({ }, "XF86AudioLowerVolume", function() awful.spawn.with_shell("pamixer -d 3") end, {description = "Lower volume", group = "Volume"}),
    -- awful.key({ }, "XF86AudioMute", function() awful.spawn.with_shell("pamixer -t") end , {description = "Mute", group = "Volume"}),

-- Brightness
    -- awful.key({ }, "XF86MonBrightnessUp", function() awful.spawn.with_shell("brightnessctl set 3%+") end, {description = "Increase brightness", group = "Brightness"}),
    -- awful.key({ }, "XF86MonBrightnessDown", function() awful.spawn.with_shell("brightnessctl set 3%-") end, {description = "Decrease brightness", group = "Brightness"}),

-- Toggle spaces
    --awful.key({altkey}, "c", function() awesome.emit_signal("sidebar::toggle") end, {description = "Toggle sidebar", group = "Spaces"})
    awful.key({altkey}, "x", function() awesome.emit_signal("logout::toggle") end, {description = "Toggle logout", group = "Spaces"})
    --awful.key({altkey}, "z", function() awesome.emit_signal("dashboard::toggle") end, {description = "Toggle dashboard", group = "Spaces"})

-- Emacs (Super + e followed by KEY)
    -- awful.key( {modkey}, "e", function()
    --     local grabber
    --     grabber =
    --       awful.keygrabber.run(
    --         function(_, key, event)
    --           if event == "release" then return end
  
    --           if     key == "e" then awful.spawn.with_shell(emacs .. "--eval '(dashboard-refresh-buffer)'")
    --           elseif key == "a" then awful.spawn.with_shell(emacs .. "--eval '(emms)' --eval '(emms-play-directory-tree \"~/Music/\")'")
    --           elseif key == "b" then awful.spawn.with_shell(emacs .. "--eval '(ibuffer)'")
    --           elseif key == "d" then awful.spawn.with_shell(emacs .. "--eval '(dired nil)'")
    --           elseif key == "i" then awful.spawn.with_shell(emacs .. "--eval '(erc)'")
    --           elseif key == "n" then awful.spawn.with_shell(emacs .. "--eval '(elfeed)'")
    --           elseif key == "s" then awful.spawn.with_shell(emacs .. "--eval '(eshell)'")
    --           elseif key == "v" then awful.spawn.with_shell(emacs .. "--eval '(+vterm/here nil)'")
    --           elseif key == "w" then awful.spawn.with_shell(emacs .. "--eval '(doom/window-maximize-buffer(eww \"distro.tube\"))'")
    --           end
    --           awful.keygrabber.stop(grabber)
    --           end
    --         )
    --       end,
    --       {description = "Followed by KEY", group = "Emacs"}
    --       ),   
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = my_table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
    end,
    {description = "View tag #"..i, group = "Tag"}),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end,
    {description = "Toggle tag #" .. i, group = "Tag"}),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
    function ()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
    {description = "Move focused client to tag #"..i, group = "Tag"}),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
    function ()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:toggle_tag(tag)
            end
        end
    end,
    {description = "Toggle focused client on tag #" .. i, group = "Tag"})
)
end

-- Set keys
root.keys(globalkeys)

-- Client
client_keys = my_table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "Toggle fullscreen", group = "Client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "Close", group = "Client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "Toggle floating", group = "Client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "Move to master", group = "Client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "Move to screen", group = "Client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "Toggle keep on top", group = "Client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "Client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "Client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "Client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "Client"})
)
-- }}}


-- MOUSEBINDINGS {{{
-- 3 = left click
-- 4 = scroll up
-- 5 = scroll down
globalmouse = my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({modkey, }, 5, awful.tag.viewnext),
    awful.button({modkey, }, 4, awful.tag.viewprev)
)
-- Set mouse
root.buttons(globalmouse)

-- Taglist
awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end)
)

-- Tasklist
awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({ }, 3, function()
        local instance = nil
		return function()
			if instance and instance.wibox.visible then
				instance:hide()
				instance = nil
			else
				instance = awful.menu.clients({theme = {width = 250}})
			end
		end
	end),
    awful.button({ }, 5, function() awful.client.focus.byidx(1) end),
    awful.button({ }, 4, function() awful.client.focus.byidx(-1) end)
)

-- Clients
client_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)
-- }}}


-- RULES {{{
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
            "DTA",  -- Firefox addon DownThemAll.
            "copyq",  -- Includes session name in class.
            "pinentry",
        },
        class = {
            "Arandr",
            "Blueman-manager",
            "Gpick",
            "Kruler",
            "MessageWin",  -- kalarm.
            "Sxiv",
            "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
            "Wpa_gui",
            "veromix",
            "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            "Event Tester",  -- xev.
        },
        role = {
            "AlarmWindow",  -- Thunderbird's calendar.
            "ConfigManager",  -- Thunderbird's about:config.
            "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
    }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
        }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}
