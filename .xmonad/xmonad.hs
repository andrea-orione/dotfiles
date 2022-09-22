--    ____     ____
--  /  __  \ /  __  \
-- |  |__|  |  |  |  |  Andrea Orione
-- |   __   |  |  |  |  https://www.github.com/andrea-orione
-- |  |  |  |  |__|  |
-- |__|  |__|\ ____ / 
--
--
-- Customisation of Xmonad

-- IMPORTS
import XMonad
import XMonad.Layout.Fullscreen
    ( fullscreenEventHook, fullscreenManageHook, fullscreenSupport, fullscreenFull )
import Data.Monoid
import System.Exit
import XMonad.Util.SpawnOnce ( spawnOnce )
import Graphics.UI.GLUT.Window
import XMonad.Actions.CycleWS
import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp, xF86XK_AudioPlay, xF86XK_AudioPrev, xF86XK_AudioNext)
import XMonad.Hooks.EwmhDesktops ( ewmh )
import Control.Monad ( join, when )
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
    ( avoidStruts, docks, manageDocks, Direction2D(D, L, R, U) )
import XMonad.Hooks.ManageHelpers ( doFullFloat, isFullscreen )
import XMonad.Layout.Spacing ( spacingRaw, Border(Border) )
import XMonad.Layout.Gaps
    ( Direction2D(D, L, R, U),
      gaps,
      setGaps,
      GapMessage(DecGap, ToggleGaps, IncGap) )

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Maybe (maybeToList)

-- Choose one between theese color schemes:
  -- DoomOne
import Colors.DoomOne


-- VARIABLES
myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "firefox"

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs'" --Opens in a new frame starting the deamon if it is not running

myVscode :: String
myVscode = "code -n" --Opens in a new window

myEditor :: String
myEditor = myEmacs
--myEditor = myVscode
--myEditor = myTerminal ++ " -e vim "

myFont :: String
myFont = "xft:Ubuntu Mono:regular:size=9:antialias=true:hinting=true"

myFocusFollowsMouse :: Bool -- Whether focus follows the mouse pointer
myFocusFollowsMouse = True

myClickJustFocuses :: Bool -- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses = False

myModMask :: KeyMask -- Which modkey you want to use
myModMask = mod4Mask
-- mod1Mask = left alt (default). Please not use this since the next variable would be ambiguous
-- mod3Mask = right alt
-- mod4Mask = super

myAltMask :: KeyMask -- 
myAltMask = mod1Mask

myBorderWidth :: Dimension -- Width of the window border in pixels
myBorderWidth = 2

myNormalBorderColor :: String -- Border color for unfocused windows
myNormalBorderColor  = colorBack -- Imported from Colors.THEME

myFocusedBorderColor :: String -- Border color for unfocused windows
myFocusedBorderColor = color15

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a workspace name.
-- The number of workspaces is determined by the length of this list.
-- Example:
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
myWorkspaces    = ["Dev", "Tex", "Www", "Doc", "Mus", "Set", "Ter", "Ot1", "Ot2", "Ot3"]

-- Random stuff
addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X () -- Extended Window manager Hint System
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

-- KEYBINDINGS
-- Command variables
clipboardMananager :: MonadIO m => m () -- Just copied. Don't know why you have to declare only this 
clipboardMananager = spawn "rofi -modi \"\63053 :greenclip print\" -show \"\63053 \" -run-command '{cmd}' -theme ~/.config/rofi/launcher/style.rasi" -- Spawns the clipboard (copy/paste database)

screenshotCopy = spawn "maim -s | xclip -selection clipboard -t image/png && notify-send \"Screenshot\" \"Copied to Clipboard\" -i flameshot"
screenshotSave = spawn "maim -s ~/Desktop/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot\" \"Saved to Desktop\" -i flameshot"
rofiLauncher = spawn "rofi -no-lazy-grab -show drun -modi run,drun,window -theme $HOME/.config/rofi/launcher/style -drun-icon-theme \"candy-icons\" "

-- Actual keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- Xmonad bindings
    [ ((modm .|. controlMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart") --restart Xmonad
    , ((modm .|. shiftMask,   xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -")) -- keybindings help
    , ((modm .|. shiftMask,   xK_c     ), kill) -- close focused window
    , ((modm,                 xK_p     ), rofiLauncher) -- Launches rofi launcher
    , ((modm .|. shiftMask,   xK_p     ), spawn "gmrun") -- Launches gmrun launcher
    , ((modm,                 xK_F1    ), spawn "betterlockscreen -l") -- Launches lockscreen
    , ((modm .|. shiftMask,   xK_q     ), io (exitWith ExitSuccess)) -- Quits xmonad
    
    -- Launcher
    , ((modm,                 xK_Return), spawn $ XMonad.terminal conf) -- Spawn terminal
    , ((modm,                 xK_b), spawn $ myBrowser) -- Spawn browser

    -- Spaces
    , ((modm .|. myAltMask,   xK_g     ), spawn "exec ~/.bin/toggleDashboard.sh")
    , ((modm .|. myAltMask,   xK_c     ), spawn "exec ~/.bin/toggleSidebar.sh")
    , ((modm,                 xK_Escape), spawn "exec ~/.bin/eww close-all")

    -- Audio keys
    , ((0,                    xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((0,                    xF86XK_AudioPrev), spawn "playerctl previous")
    , ((0,                    xF86XK_AudioNext), spawn "playerctl next")
    , ((0,                    xF86XK_AudioRaiseVolume), spawn "pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +5%")
    , ((0,                    xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 +5%")
    , ((0,                    xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle ")
    
    -- Brightness keys
    , ((0,                    xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%")
    , ((0,                    xF86XK_MonBrightnessDown), spawn "brightnessctl s 10-%")

    -- Screenshot keys
    , ((0,                    xK_Print), screenshotSave)
    , ((modm,                 xK_Print), screenshotCopy)

    -- Layout keys
    , ((modm,                 xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask,   xK_space ), setLayout $ XMonad.layoutHook conf) -- Reset the layouts on the current workspace to default
    , ((modm,                 xK_l     ), sendMessage Expand) -- Expand the master area
    , ((modm,                 xK_h     ), sendMessage Shrink) -- Shrink the master area
    , ((modm,                 xK_n     ), refresh) -- Resize viewed windows to the correct size
    , ((modm .|. shiftMask,   xK_h ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    , ((modm .|. shiftMask,   xK_l), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area

    -- Client focus keys
    , ((modm,                 xK_Tab   ), windows W.focusDown   ) -- Move focus to the next window
    , ((modm,                 xK_j     ), windows W.focusDown   ) -- Move focus to the next window
    , ((modm .|. shiftMask,   xK_Tab   ), windows W.focusUp   ) -- Move focus to the previous window
    , ((modm,                 xK_k     ), windows W.focusUp     ) -- Move focus to the previous window
    , ((modm,                 xK_m     ), windows W.focusMaster ) -- Move focus to the master window
    , ((modm .|. shiftMask,   xK_j     ), windows W.swapDown    ) -- Swap the focused window with the next window
    , ((modm .|. shiftMask,   xK_k     ), windows W.swapUp      ) -- Swap the focused window with the previous window
    , ((modm .|. shiftMask,   xK_m     ), windows W.swapMaster  ) -- Swap the focused window and the master window

    -- Client appearence keys
    , ((modm .|. controlMask, xK_space ), withFocused $ windows . W.float ) -- Set current window to floating
    , ((modm,                 xK_t     ), withFocused $ windows . W.sink  ) -- Set current window to tiling
    , ((modm,                 xK_f     ), withFocused $ maximizeWindow    ) -- Maximize current window
    , ((modm .|. shiftMask,   xK_f     ), withFocused $ fullScreenToggle  ) -- Toggle fullscreen for the current window
    
    , ((modm .|. controlMask, xK_g     ), sendMessage $ ToggleGaps)         -- toggle all gaps
    , ((modm .|. shiftMask,   xK_g     ), sendMessage $ setGaps [(L,30), (R,30), (U,40), (D,60)]) -- reset the GapSpec
    , ((modm .|. controlMask, xK_t     ), sendMessage $ IncGap 10 L)        -- increment the left-hand gap
    , ((modm .|. shiftMask,   xK_t     ), sendMessage $ DecGap 10 L)        -- decrement the left-hand gap
    , ((modm .|. controlMask, xK_y     ), sendMessage $ IncGap 10 U)        -- increment the top gap
    , ((modm .|. shiftMask,   xK_y     ), sendMessage $ DecGap 10 U)        -- decrement the top gap
    , ((modm .|. controlMask, xK_u     ), sendMessage $ IncGap 10 D)        -- increment the bottom gap
    , ((modm .|. shiftMask,   xK_u     ), sendMessage $ DecGap 10 D)        -- decrement the bottom gap
    , ((modm .|. controlMask, xK_i     ), sendMessage $ IncGap 10 R)        -- increment the right-hand gap
    , ((modm .|. shiftMask,   xK_i     ), sendMessage $ DecGap 10 R)        -- decrement the right-hand gap

    
    -- Workspaces and screen focus keys
    , ((modm,                 xK_Right ), nextWS  ) -- Show next workspace
    , ((modm,                 xK_Left  ), prevWS ) -- Show previous workspace
    , ((modm .|. shiftMask,   xK_Right ), shiftToNext) -- Move focused window to the next workspace
    , ((modm .|. shiftMask,   xK_Left  ), shiftToPrev) -- Move focused window to the previous workspace
    , ((modm .|. controlMask, xK_j  ), nextScreen ) -- Show next screen 
    , ((modm .|. controlMask, xK_k  ), prevScreen ) -- Show previous screen 
    , ((modm .|. controlMask .|. shiftMask, xK_j), shiftNextScreen) -- Move focused window to the next screen
    , ((modm .|. controlMask .|. shiftMask, xK_k),  shiftPrevScreen) -- Move focused window to the previous screen
    ]
    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- MOUSE BINDINGS
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button4), nextWS) -- Moves to next workspace
    , ((modm, button5), prevWS) -- Moves to next screen
    , ((modm .|. controlMask, button4), nextScreen) -- Moves to next workspace
    , ((modm .|. controlMask, button5), prevScreen) -- Moves to previous screen
    ]

-- LAYOUTS
myLayout = tiled ||| Mirror tiled ||| Full ||| floats
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

-- RULES:
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "gmrun"          --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- EVENT HADLING
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
myEventHook = mempty

-- STATUS BAR AND LOGGING
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
myLogHook = return ()

-- STARTUP HOOK
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
-- By default, do nothing.
myStartupHook = do
  spawnOnce "exec ~/bin/bartoggle" -- Starts topbar and dock
  spawnOnce "exec ~/bin/eww daemon" -- Start eww daemon
  spawn "xsetroot -cursor_name left_ptr"
  spawn "exec ~/bin/lock.sh" -- Automatic locking screen
  spawnOnce "feh --bg-scale ~/wallpapers/yosemite-lowpoly.jpg" -- Sets wallpapers
  spawnOnce "picom" -- Starts compositor
  spawnOnce "greenclip daemon" -- Starts greenclip daemon
  spawnOnce "dunst" -- Starts dunst

-- INITIALISATION
main = xmonad $ fullscreenSupport $ docks $ ewmh defaults
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        clickJustFocuses   = myClickJustFocuses,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = gaps [(L,10), (R,10), (U,10), (D,10)] $ spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook >> addEWMHFullscreen
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'super'. Default keybindings:",
    "",
    "-- Xmonad"
    "mod-Control-r            Restart Xmonad",
    "mod-Shift-/              Show keybindings",
    "mod-Shift-c              Close focused window",
    "mod-p                    Launches rofi launcher",
    "mod-Shift-p              Launches gmrun launcher",
    "mod-F1                   Launches lockscreen",
    "mod-Shift-q              Quits xmonad",
    "",
    "-- Launcher",
    "mod-Return               Spawn terminal",
    "mod-b                    Spawn browser",
    "",
    "-- Spaces",
    "mod-Alt-g                Toggle dashboard",
    "mod-Alt-c                Toggle sidebar",
    "mod-Escape               Close all spaces",
    "",
    "-- Screenshot",
    "Print                    Make screenshot and save it",
    "mod-Print                Make screenshot and copy it to the clipboard",
    "",
    "-- Layout",
    "mod-Space                Rotate through the available layouts",
    "mod-Shift-Space          Reset the layouts on the current workspace to default",
    "mod-l                    Expand the master area",
    "mod-h                    Shrink the master area",
    "mod-n                    Resize viewed windows to the correct size",
    "mod-Shift-h              Increment the number of windows in the master area",
    "mod-Shift-l              Deincrement the number of windows in the master area",
    "",
    "-- Client focus",
    "mod-Tab                  Move focus to the next window",
    "mod-j                    Move focus to the next window",
    "mod-Shift-Tab            Move focus to the previous window",
    "mod-k                    Move focus to the previous window",
    "mod-m                    Move focus to the master window",
    "mod-Shift-j              Swap the focused window with the next window",
    "mod-Shift-k              Swap the focused window with the previous window",
    "mod-Shift-m              Swap the focused window and the master window",
    "",
    "-- Client appearence",
    "mod-Control-Space        Set current window to floating",
    "mod-t                    Set current window to tiling",
    "mod-f                    Maximize current window",
    "mod-Shift-f              Toggle fullscreen for the current window",
    "",
    "-- Workspaces and screen focus",
    "mod-Right                Show next workspace",
    "mod-Left                 Show previous workspace",
    "mod-Shift-Right          Move focused window to the next workspace",
    "mod-Shift-Left           Move focused window to the previous workspace",
    "mod-Control-j            Show next screen ",
    "mod-Control-k            Show previous screen ",
    "mod-Control-Shift-j      Move focused window to the next screen",
    "mod-Control-Shift-k      Move focused window to the previous screen",
    "mod-[1..9],              Switch to workspace N",
    "mod-Shift-[1..9]         Move client to workspace N",
    "mod-{w,e,r}              Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}        Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings",
    "mod-button1              Set the window to floating mode and move by dragging",
    "mod-button2              Raise the window to the top of the stack",
    "mod-button3              Set the window to floating mode and resize by dragging",
    "mod-button4              Moves to next workspace",
    "mod-button5              Moves to next screen",
    "mod-Control-button4      Moves to next workspace",
    "mod-Control-button5      Moves to previous screen"]