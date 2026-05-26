-- https://wiki.hypr.land/Configuring/Basics/Variables/#groupbar

hl.config({
  group = {
    groupbar = {
      enabled = true,                          -- enables groupbar
      font_family = "",                        -- font used to display groupbar titles, use `misc.font_family` if not specified
      font_size = 8,                           -- font size of groupbar title
      font_weight_active = "normal",           -- font weight of active groupbar title
      font_weight_inactive = "normal",         -- font weight of inactive groupbar title
      gradients = false,                       -- enable gradients
      height = 14,                             -- height of the groupbar
      indicator_gap = 0,                       -- height of gap between groupbar indicator and title
      indicator_height = 3,                    -- height of the groupbar indicator
      stacked = false,                         -- render the groupbar as a vertical stack
      priority = 3,                            -- sets the decoration priority for groupbars
      render_titles = true,                    -- whether to render titles in the group bar decoration
      text_offset = 0,                         -- adjust vertical position for titles
      text_padding = 0,                        -- set horizontal padding for titles
      scrolling = true,                        -- whether scrolling in the groupbar changes group active window
      rounding = 1,                            -- how much to round the indicator
      rounding_power = 2.0,                    -- adjusts the curve used for rounding groupbar corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
      gradient_rounding = 2,                   -- how much to round the gradients
      gradient_rounding_power = 2.0,           -- adjusts the curve used for rounding gradient corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
      round_only_edges = true,                 -- round only the indicator edges of the entire groupbar
      gradient_round_only_edges = true,        -- round only the gradient edges of the entire groupbar
      text_color = 0xffffffff,                 -- color for window titles in the groupbar
      text_color_inactive = 0xffffffff,        -- color for inactive windows' titles in the groupbar (if unset, defaults to `text_color`)
      text_color_locked_active = 0xffffffff,   -- color for the active window’s title in a locked group (if unset, defaults to `text_color`)
      text_color_locked_inactive = 0xffffffff, -- color for inactive windows’ titles in locked groups (if unset, defaults to text_color_inactive)
      col = {
        active = 0x66ffff00,                   -- active group bar background color
        inactive = 0x66777700,                 -- inactive (out of focus) group bar background color
        locked_active = 0x66ff5500,            -- active locked group bar background color
        locked_inactive = 0x66775500,          -- inactive locked group bar background color
      },
      gaps_in = 2,                             -- gap size between gradients
      gaps_out = 2,                            -- gap size between gradient and window
      keep_upper_gap = true,                   -- add or remove upper gap
      middle_click_close = true,               -- whether middle clicking the groupbar closes the clicked window
      blur = false,                            -- applies blur to the groupbar indicator and gradients
    }
  }
})
