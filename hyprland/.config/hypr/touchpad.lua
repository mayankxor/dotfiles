hl.config({
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad
  input = {
    touchpad = {
      disable_while_typing = true,     -- Disable the touchpad while typing.
      natural_scroll = false,          --  Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.
      scroll_factor = 1.0,             -- Multiplier applied to the amount of scroll movements.
      middle_button_emulation = false, -- Sending LMB and RMB simultaneously will be interpreted as a middle click. This disables any touchpad area that would normally send a middle click based on location. https://wayland.freedesktop.org/libinput/doc/latest/middle-button-emulation.html
      tap_button_map = "",             -- Sets the tap button mapping for touchpad button emulation. Can be one of "lrm"(default) or "lmr"(Left, Middle, Right Buttons). ["lrm"/"lmr"]
      clickfinger_behavior = false,    -- Button presses with 1, 2, or 3 fingers will be mapped to LMB, RMB, and MMB respectively. This disables interpretations of clicks based on location on the touchpad. https://wayland.freedesktop.org/libinput/doc/latest/clickpad-softbuttons.html#clickfinger-behavior
      tap_to_click = true,             -- Tapping on the touchpad with 1, 2, or 3 fingers will send LMB, RMB, and MMB respectively.
      drag_lock = 0,                   -- When enabled, lifting the finger off while dragging will not drop the dragged item. 0 -> disabled, 1 -> enabled with timeout, 2 -> enabled sticky. https://wayland.freedesktop.org/libinput/doc/latest/tapping.html#tap-and-drag
      tap_and_drag = true,             -- Sets the tap and drag mode for the touchpad
      flip_x = false,                  -- Inverts the horizontal movement of the touchpad
      flip_y = false,                  -- Inverts the vertical movement of the touchpad
      drag_3fg = 0,                    -- Enables three finger drag, 0 -> disabled, 1 -> 3 fingers, 2 -> 4 fingers. https://wayland.freedesktop.org/libinput/doc/latest/drag-3fg.html
    },
  }
})
