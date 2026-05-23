-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#general
  general = {
    border_size             = 2,                                                               -- size of the border around windows
    gaps_in                 = 2,                                                               -- gaps between windows
    gaps_out                = 8,                                                               -- gaps between windows and monitor edges
    float_gaps              = 0,                                                               -- gaps between windows and monitor edges for floating windows, `-1` means default
    gaps_workspaces         = 0,                                                               -- gaps between workspaces. Stacks with `gaps_out`
    col                     = {
      inactive_border       = "rgba(595959aa)",                                                -- border color for inactive windows
      active_border         = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }, -- border color for active window
      nogroup_border        = 0xffffaaff,                                                      -- inactive border color for window that cannot be added to a group (see `hl.dsp.window.deny_from_group dispatcher`)
      nogroup_border_active = 0xffff00ff,                                                      -- active border color for window that cannot be added to a group
    },
    layout                  = "dwindle",                                                       -- which layout to use. ["dwindle"/"master"/"scrolling"/"monocle"]
    no_focus_fallback       = false,                                                           -- if true, will not fall back to the next available window when moving focus in a direction where no window was found
    resize_on_border        = false,                                                           -- enables resizing windows by clicking and dragging on borders and gaps
    extend_border_grab_area = 15,                                                              -- extends the area around the border where you can click and drag on, only used when `general.resize_on_border` is on.
    hover_icon_on_border    = true,                                                            -- show a cursor icon when hovering over borders, only used when `general.resize_on_border` is on.
    allow_tearing           = false,                                                           -- master switch for allowing tearing to occur. See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    resize_corner           = 0,                                                               -- force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable)
    modal_parent_blocking   = true,                                                            -- whether parent windows of modals will be interactive
    locale                  = [[]],                                                            -- overrides the system locale (e.g. "en_US", "es")

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#snap
    snap                    = {
      enabled = false,        -- enable snapping for floating windows
      window_gap = 10,        -- minimum gap in pixels between windows before snapping
      monitor_gap = 10,       -- minimum gap in pixels between window and monitor edges before snapping
      border_overlap = false, -- if true, windows snap such that only one border's worth of space is between them
      respect_gaps = false,   -- if true, snapping will respect gaps between windows(set in general:gaps_in)
    },
  },

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

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
    blur                  = {
      enabled                   = true,   -- enable kawase window background blur
      size                      = 8,      -- blur size (distance)
      passes                    = 1,      -- the amount of passes to perform
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

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#shadow
    shadow                = {
      enabled        = true,       -- enable drop shadows on windows
      range          = 4,          -- Shadow range ("size") in layout px
      render_power   = 3,          -- in what power to render the falloff (more power, the faster falloff) [1 - 4]
      sharp          = false,      -- if enabled, will make the shadows sharp, akin to an infinite render power
      color          = 0xee1a1a1a, -- shadow's color. Alpha dictates shadow's opacity
      color_inactive = 0xee1a1a1a, -- inactive shadow color. (if not set, will fall back to color)
      offset         = { 0, 0 },   -- shadow's rendering offset.
      scale          = 1.0,        -- shadow's scale. [0.0 - 1.0]
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#glow
    glow                  = {
      enabled = true,              -- enable inner glow on windows
      range = 10,                  -- Glow range ("size") in layout px
      render_power = 3,            -- in what power to render the falloff (more power, the faster the falloff) [1 - 4]
      color = 0xee1a1a1a,          -- glow's color. Alpha dictates glow's opacity.
      color_inactive = 0xee1a1a1a, -- inactive glow color. (if not set, will fall back to color)
    }
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
  animations = {
    enabled = true,              -- enable animations
    workspace_wraparound = true, -- enable workspace wraparound, causing directional workspace animations to animate as if the first and last workspaces were adjacent
  },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})
