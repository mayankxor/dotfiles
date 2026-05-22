-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
  general = {
    border_size             = 2,                                                               -- size of the border around windows
    gaps_in                 = 2,                                                               -- gaps between windows
    gaps_out                = 8,                                                               -- gaps between windows and monitor edges
    float_gaps              = 0,                                                               -- gaps between windows and monitor edges for floating windows, `-1` means default
    gaps_workspaces         = 0,                                                               -- gaps between workspaces. Stacks with `gaps_out`
    col                     = {
      inactive_border       = "rgba(595959aa)",                                                -- border color for inactive windows
      active_border         = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }, -- border color for active window
      nogroup_border        = 0xffffaaff,                                                      -- inactive border color for window that cannot be added to a group (see hl.dsp.window.deny_from_group dispatcher)
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
  },

  decoration = {
    rounding         = 10,
    rounding_power   = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
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
