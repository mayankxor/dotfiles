-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc

hl.config({
  misc = {
    disable_hyprland_logo = true,           -- disables the random Hyprland logo/anime girl background
    disable_splash_rendering = true,        -- disables the Hyprland splash rendering (requires monitor reload to take effect)
    disable_scale_notification = false,     -- disables notification popup when a monitor fails to set a suitable scale
    col = {
      splash = 0xffffffff,                  -- Changes the color of the splash text (requires a monitor reload to take effect).
    },
    font_family = "Noto Sans Mono",         -- Set the global default font to render the text including debug fps/notification, config error messages and etc., selected from system fonts.
    splash_font_family = "",                -- Changes the font used to render the splash text, selected from system fonts (requires a monitor reload to take effect).
    force_default_wallpaper = 0,            -- Enforce any of the 3 default wallpapers. Setting this to 0 or 1 disables the anime background. -1 means “random”. [-1/0/1/2]
    vrr = 0,                                -- Controls the VRR (adaptive Sync) of your monitors. 0 - off, 1 - on, 2 - fullscreen only, 3 - fullscreen with `video` or `game` content type [0/1/2/3]
    mouse_move_enables_dpms = false,        -- If DPMS is set to off, wake up the monitors if a key is pressed
    name_vk_after_proc = true,              -- Name virtual keyboards after the processes that create them. E.g. /usr/bin/fcitx5 will have hl-virtual-keyboard-fcitx5
    always_follow_on_dnd = true,            -- Will make mouse focus follow the mouse when drag and dropping. Recommended to leave it enabled, especially for people using focus follows mouse at 0.
    layers_hog_keyboard_focus = true,       -- If true, will make keyboard-interactive layers keep their focus on mouse move (r.g. wofi, bemenu)
    animate_manual_resizes = false,         -- If true, will animate manual window resizes/moves
    animate_mouse_windowdragging = false,   -- If true, will animate windows being dragged by mouse, note that this can cause weird behaviour on some curves.
    disable_autoreload = false,             -- If true, the config will not reload automatically on save, and instead needs to be loaded with `hyprctl reload`. Might save on battery.
    enable_swallow = false,                 -- enable window swallowing
    swallow_regex = "",                     -- The class regex to be used for windows that should be swallowed (usually, a terminal). To know more about the list of regex which can be used, see https://github.com/ziishaned/learn-regex/blob/master/README.md
    swallow_exception_regex = "",           -- The title regex to be used for windows that should not be swallowed by the window specified in `swallow_regex` (e.g. wev). The regex is matched against the parent (e.g. kitty) window's title on the assumption that it changes to whatever the process it's running
    focus_on_activate = false,              -- Whether Hyprland should focus an app that requests to be focused (an `activate` request)
    mouse_move_focuses_monitor = true,      -- Whether mouse moving into a different monitor should focus it
    allow_session_lock_restore = false,     -- If true, will allow you to restart a lockscreen app in case it crashes
    session_lock_xray = false,              -- If true, keep rendering workspaces below your lockscreen
    background_color = 0x111111,            -- Change the background color. (requires enabled `disable_hyprland_logo`)
    close_special_on_empty = true,          -- close the special workspace if last window is removed
    on_focus_under_fullscreen = 2,          -- f there is a fullscreen or maximized window, decide whether a tiled window requested to focus should replace it, stay behind or disable the fullscreen/maximized state. 0 - ignore focus request (keep focus on fullscreen window), 1 - takes over, 2 - unfullscreen/unmaximize [0/1/2]
    exit_window_retains_fullscreen = false, -- If true, closing a fullscreen window makes the next focused window fullscreen
    initial_workspace_tracking = 1,         -- If enabled, window will open on the workspace they were invoked on. 0 - disabled, 1 - single-shot, 2 - persistent (all children too)
    middle_click_paste = true,              -- Whether to enable middle-click-paste (aka primary selection)
    render_unfocused_fps = 15,              -- The maximum limit for `render_unfocused` windows' fps in the background (see also, https://wiki.hypr.land/Configuring/Basics/Window-Rules/#dynamic-effects - `render_unfocused`)
    disable_xdg_env_checks = false,         -- Disable the warning if XDG environment is externally managed
    -- BUG: Doesnt recognize this field
    -- disable_hyprland_qtutils_check = false, -- Disable the warning if hyprland-qtutils is not installed
    lockdead_screen_delay = 1000,     -- Delay after which the "lockdead" screen will appear in case a lockscreen app fails to cover all the outputs (5 seconds max)
    enable_anr_dialog = true,         -- Whether to enable the ANR (app not responding) dialog when your apps hang
    anr_missed_pings = 5,             -- Number of missed pings before showing the ANR dialog
    size_limits_tiled = false,        -- Whether to apply `min_size` and `max_size` rules to tiled windows
    disable_watchdog_warning = false, -- Whether to disable the warning about not using start-hyprland
  },
})
