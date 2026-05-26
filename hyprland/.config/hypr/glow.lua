hl.config({
  decoration = {
    -- https://wiki.hypr.land/Configuring/Basics/Variables/#glow
    glow = {
      enabled = true,              -- enable inner glow on windows
      range = 10,                  -- Glow range ("size") in layout px
      render_power = 3,            -- in what power to render the falloff (more power, the faster the falloff) [1 - 4]
      color = 0xee1a1a1a,          -- glow's color. Alpha dictates glow's opacity.
      color_inactive = 0xee1a1a1a, -- inactive glow color. (if not set, will fall back to color)
    },
  }
})
