hl.config({
  decoration = {
    -- https://wiki.hypr.land/Configuring/Basics/Variables/#shadow
    shadow = {
      enabled        = true,       -- enable drop shadows on windows
      range          = 4,          -- Shadow range ("size") in layout px
      render_power   = 3,          -- in what power to render the falloff (more power, the faster falloff) [1 - 4]
      sharp          = false,      -- if enabled, will make the shadows sharp, akin to an infinite render power
      color          = 0xee1a1a1a, -- shadow's color. Alpha dictates shadow's opacity
      color_inactive = 0xee1a1a1a, -- inactive shadow color. (if not set, will fall back to color)
      offset         = { 0, 0 },   -- shadow's rendering offset.
      scale          = 1.0,        -- shadow's scale. [0.0 - 1.0]
    },
  }
})
