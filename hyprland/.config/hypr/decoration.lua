hl.config({
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
  decoration = {
    rounding              = 6,     -- rounded corners' radius(in layout px)
    rounding_power        = 2.0,   -- adjusts the curve used for rounding corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
    active_opacity        = 1.0,   -- opacity of active windows. [0.0 - 1.0]
    inactive_opacity      = 0.75,  -- opacity of inactive windows. [0.0 - 1.0]
    fullscreen_opacity    = 1.0,   -- opacity of fullscreen windows. [0.0 - 1.0]
    dim_modal             = true,  -- enables dimming of parents of modal windows
    dim_inactive          = false, -- enables dimming of inactive windows
    dim_strength          = 0.5,   -- how much inactive windows should be dimmed [0.0 - 1.0]
    dim_special           = 0.2,   -- how much to dim the rest of the screen by when a special workspace is open. [0.0 - 1.0]
    dim_around            = 0.4,   -- how much the `dim_around` window rule should dim by. [0.0 - 1.0]
    screen_shader         = [[]],  -- a path to a custom shader to be applied at the end of rendering. See
    border_part_of_window = true,  -- whether the window border should be a part of the window
  },
})
