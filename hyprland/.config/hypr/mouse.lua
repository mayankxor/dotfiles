hl.config({
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#input
  -- INFO: Follow Mouse Cursor
  -- 0 - Cursor movement will not change focus.
  -- 1 - Cursor movement will always change focus to the window under the cursor.
  -- 2 - Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
  -- 3 - Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.

  -- INFO: Custom Accel Profiles
  -- `accel_profile`: custom <step> <points...>
  -- Example: custom 200 0.0 0.5
  --
  -- INFO: scroll_points (Only works when `accel_profile` is set to `custom`)
  -- <step> <points...>
  -- Example: 0.2 0.0 0.5 1 1.2 1.5

  -- HACK: To mimic the Windows acceleration curves, take a look at scripts/windowAccelerationCurve.py
  -- See https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html for more insights on how it works.

  input = {
    sensitivity                 = 0,          -- Sets the mouse input sensitivity. Value is clamped to the range -1.0 to 1.0. https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html#pointer-acceleration
    accel_profile               = "adaptive", -- Sets the cursor acceleration profile. Can be one of "adaptive", "flat". Can also be "custom", see https://wiki.hypr.land/Configuring/Basics/Variables/#accel_profile. Leave empty to use `libinput’s` default mode for your input device. https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html#pointer-acceleration ["adaptive"/"flat"/"custom"]
    force_no_accel              = false,      -- Force no cursor acceleration. This bypasses most of your pointer settings to get as raw of a signal as possible. Enabling this is not recommended due to potential cursor desynchronization.
    rotation                    = 0,          -- Sets the rotation of a device in degrees clockwise off the logical neutral position. Value is clamped to the range 0 to 359.
    left_handed                 = false,      -- Switches RMB and LMB
    scroll_points               = "",         -- Sets the scroll acceleration profile, when `accel_profile` is set to "custom". Has to be in the form "<step> <points>". Leave empty to have a flat scroll curve.
    scroll_method               = "",         -- Sets the scroll method. Can be one of "2fg" (2 fingers), "edge", "on_button_down", "no_scroll". https://wayland.freedesktop.org/libinput/doc/latest/scrolling.html ["2fg"/"edge"/"on_button_down"/"no_scroll"]
    scroll_button               = 0,          -- Sets the scroll button. Has to be an int, cannot be a string. Check wev if you have any doubts regarding the ID. 0 means default.
    scroll_button_lock          = false,      -- If the scroll button lock is enabled, the button does not need to be held down. Pressing and releasing the button toggles the button lock, which logically holds the button down or releases it. While the button is logically held down, motion events are converted to scroll events.
    scroll_factor               = 1.0,        -- Multiplier added to scroll movement for external mice. Note that there is a separate setting for touchpad_scroll_factor(touchpad.lua)
    natural_scroll              = false,      -- Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.
    follow_mouse                = 1,          -- Specify if and how cursor movement should affect window focus. See the note above. [0/1/2/3]
    follow_mouse_shrink         = 0,          -- Shrinks the inactive window hitboxes used for focus detection by the specified number of pixels. This creates a dead zone in gaps between windows where moving the cursor will not change focus. Works only with follow_mouse = 1.
    follow_mouse_threshold      = 0.0,        -- The smallest distance in logical pixels the mouse needs to travel for the window under it to get focused. Works only with follow_mouse = 1.
    focus_on_close              = 0,          -- Controls the window focus behavior when a window is closed. When set to 0, focus will shift to the next window candidate. When set to 1, focus will shift to the window under the cursor. When set to 2, focus will shift to the most recently used/active window. [0/1/2]
    mouse_refocus               = true,       -- If disabled, mouse focus won't switch to the hovered window unless the mouse crosses a window boundary when `follor_mouse=1`
    float_switch_override_focus = 1,          -- If enabled (1 or 2), focus will change to the window under the cursor when changing from tiles-to-floating and vice versa. If 2, focus will also follow mouse on float-to-float switches.
    special_fallthrough         = false,      -- If enabled, having only floating windows in the special workspace will not block focusing windows in the regular workspace.
    off_window_axis_events      = 1,          -- Handles axis events around (gaps/border for tiled, dragarea/border for floated) a focused window. 0 ignores axis events, 1 sends out-of-bound coordinates, 2 fakes pointer coordinates to the closest point inside the window, 3 wraps the cursor to the closest point inside the window.
    emulate_discrete_scroll     = 1,          -- Emulates discrete scrolling from high resolution scrolling events. 0 disables it, 1 enables handling of non-standard events only, and 2 force enables all scroll wheel events to be handled.
  },
})
