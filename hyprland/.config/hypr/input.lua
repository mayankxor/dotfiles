hl.config({
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#input
  input = {
    kb_model                    = "",    -- Appropriate XKB keymap parameter.
    kb_layout                   = "us",  -- Appropriate XKB keymap parameter.
    kb_variant                  = "",    -- Appropriate XKB keymap parameter.
    kb_options                  = "",    -- Appropriate XKB keymap parameter.
    kb_rules                    = "",    -- Appropriate XKB keymap parameter.
    kb_file                     = "",    -- If you prefer, you can use a path to your custom .xkb file
    numlock_by_default          = true,  -- Engage numlock by default
    resolve_binds_by_sym        = false, -- Determines how keybinds act when multiple layouts are used. If false, keybinds will always act as if the first specified layout is active. If true, keybinds specified by symbols are activated when you type the respective symbol with the current layout.
    repeat_rate                 = 25,    -- The repeat rate for held-down keys, in repeats per second.
    repeat_delay                = 600,   -- Delay before a held-down key is repeated, in milliseconds
    sensitivity                 = 0,     -- Sets the mouse input sensitivity. Value is clamped to the range -1.0 to 1.0. https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html#pointer-acceleration
    accel_profile               = "",    -- Sets the cursor acceleration profile. Can be one of "adaptive", "flat". Can also be "custom", see https://wiki.hypr.land/Configuring/Basics/Variables/#accel_profile. Leave empty to use `libinput’s` default mode for your input device. https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html#pointer-acceleration ["adaptive"/"flat"/"custom"]
    force_no_accel              = false, -- Force no cursor acceleration. This bypasses most of your pointer settings to get as raw of a signal as possible. Enabling this is not recommended due to potential cursor desynchronization.
    rotation                    = 0,     -- Sets the rotation of a device in degrees clockwise off the logical neutral position. Value is clamped to the range 0 to 359.
    left_handed                 = false, -- Switches RMB and LMB
    scroll_points               = "",    -- Sets the scroll acceleration profile, when `accel_profile` is set to "custom". Has to be in the form "<step> <points>". Leave empty to have a flat scroll curve.
    scroll_method               = "",    -- Sets the scroll method. Can be one of "2fg" (2 fingers), "edge", "on_button_down", "no_scroll". https://wayland.freedesktop.org/libinput/doc/latest/scrolling.html ["2fg"/"edge"/"on_button_down"/"no_scroll"]
    scroll_button               = 0,     -- Sets the scroll button. Has to be an int, cannot be a string. Check wev if you have any doubts regarding the ID. 0 means default.
    scroll_button_lock          = false, -- If the scroll button lock is enabled, the button does not need to be held down. Pressing and releasing the button toggles the button lock, which logically holds the button down or releases it. While the button is logically held down, motion events are converted to scroll events.
    scroll_factor               = 1.0,   -- Multiplier added to scroll movement for external mice. Note that there is a separate setting for touchpad_scroll(https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad)
    natural_scroll              = false, -- Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.
    follow_mouse                = 1,     -- Specify if and how cursor movement should affect window focus. See the note below. [0/1/2/3]
    follow_mouse_shrink         = 0,     -- Shrinks the inactive window hitboxes used for focus detection by the specified number of pixels. This creates a dead zone in gaps between windows where moving the cursor will not change focus. Works only with follow_mouse = 1.
    follow_mouse_threshold      = 0.0,   -- The smallest distance in logical pixels the mouse needs to travel for the window under it to get focused. Works only with follow_mouse = 1.
    focus_on_close              = 0,     -- Controls the window focus behavior when a window is closed. When set to 0, focus will shift to the next window candidate. When set to 1, focus will shift to the window under the cursor. When set to 2, focus will shift to the most recently used/active window. [0/1/2]
    mouse_refocus               = true,  -- If disabled, mouse focus won't switch to the hovered window unless the mouse crosses a window boundary when `follor_mouse=1`
    float_switch_override_focus = 1,     -- If enabled (1 or 2), focus will change to the window under the cursor when changing from tiles-to-floating and vice versa. If 2, focus will also follow mouse on float-to-float switches.
    special_fallthrough         = false, -- If enabled, having only floating windows in the special workspace will not block focusing windows in the regular workspace.
    off_window_axis_events      = 1,     -- Handles axis events around (gaps/border for tiled, dragarea/border for floated) a focused window. 0 ignores axis events, 1 sends out-of-bound coordinates, 2 fakes pointer coordinates to the closest point inside the window, 3 wraps the cursor to the closest point inside the window.
    emulate_discrete_scroll     = 1,     -- Emulates discrete scrolling from high resolution scrolling events. 0 disables it, 1 enables handling of non-standard events only, and 2 force enables all scroll wheel events to be handled.
    touchpad                    = {
      disable_while_typing = true,       -- Disable the touchpad while typing.
      natural_scroll = false,            --  Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.
      scroll_factor = 1.0,               -- Multiplier applied to the amount of scroll movements.
      middle_button_emulation = false,   -- Sending LMB and RMB simultaneously will be interpreted as a middle click. This disables any touchpad area that would normally send a middle click based on location. https://wayland.freedesktop.org/libinput/doc/latest/middle-button-emulation.html
      tap_button_map = "",               -- Sets the tap button mapping for touchpad button emulation. Can be one of "lrm"(default) or "lmr"(Left, Middle, Right Buttons). ["lrm"/"lmr"]
      clickfinger_behavior = false,      -- Button presses with 1, 2, or 3 fingers will be mapped to LMB, RMB, and MMB respectively. This disables interpretations of clicks based on location on the touchpad. https://wayland.freedesktop.org/libinput/doc/latest/clickpad-softbuttons.html#clickfinger-behavior
      tap_to_click = true,               -- Tapping on the touchpad with 1, 2, or 3 fingers will send LMB, RMB, and MMB respectively.
      drag_lock = 0,                     -- When enabled, lifting the finger off while dragging will not drop the dragged item. 0 -> disabled, 1 -> enabled with timeout, 2 -> enabled sticky. https://wayland.freedesktop.org/libinput/doc/latest/tapping.html#tap-and-drag
      tap_and_drag = true,               -- Sets the tap and drag mode for the touchpad
      flip_x = false,                    -- Inverts the horizontal movement of the touchpad
      flip_y = false,                    -- Inverts the vertical movement of the touchpad
      drag_3fg = 0,                      -- Enables three finger drag, 0 -> disabled, 1 -> 3 fingers, 2 -> 4 fingers. https://wayland.freedesktop.org/libinput/doc/latest/drag-3fg.html
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})
