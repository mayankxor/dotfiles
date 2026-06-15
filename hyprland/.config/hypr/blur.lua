hl.config({
  decoration = {
    -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
    -- NOTE: blur.size and blur.passes have to be at least 1. Increasing blur.passes is necessary to prevent blur looking wrong on higher blur.size values, but remember that higher blur.passes will require more strain on the GPU.
    blur = {
      enabled                   = true,   -- enable kawase window background blur
      size                      = 8,      -- blur size (distance)
      passes                    = 2,      -- the amount of passes to perform
      ignore_opacity            = true,   -- make the blur layer ignore the opacity of the window
      new_optimizations         = true,   -- whether to enable further optimizations to the blur. Recommended to leave on, as it will massively improve performance.
      xray                      = false,  -- if enabled, floating windows will ignore tiled windows in their blur. Only available if new_optimizations is true. Will reduce overhead on floating blur significantly.
      noise                     = 0.0117, -- how much noise to apply. [0.0 - 1.0]
      contrast                  = 0.8916, -- contrast modulation for blur. [0.0 - 2.0]
      brightness                = 0.8172, -- brightness modulation for blur. [0.0 - 2.0]
      vibrancy                  = 0.1696, -- Increase saturation of blurred colors. [0.0 - 1.0]
      vibrancy_darkness         = 0.0,    -- How strong the effect of `vibrancy` is on dark areas . [0.0 - 1.0]
      special                   = false,  -- whether to blur behind the special workspace (note: expensive)
      popups                    = false,  -- whether to blur popups (e.g. right-click menus)
      popups_ignorealpha        = 0.2,    -- works like `ignore_alpha` in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]
      input_methods             = false,  -- whether to blur input methods (e.g. fcitx5)
      input_methods_ignorealpha = 0.2,    -- works like `ignore_alpha` in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]
    },
  }
})
