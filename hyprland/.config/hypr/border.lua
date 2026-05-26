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
    no_focus_fallback       = false,                                                           -- if true, will not fall back to the next available window when moving focus in a direction where no window was found
    resize_on_border        = false,                                                           -- enables resizing windows by clicking and dragging on borders and gaps
    extend_border_grab_area = 15,                                                              -- extends the area around the border where you can click and drag on, only used when `general.resize_on_border` is on.
    hover_icon_on_border    = true,                                                            -- show a cursor icon when hovering over borders, only used when `general.resize_on_border` is on.
    allow_tearing           = false,                                                           -- master switch for allowing tearing to occur. See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    resize_corner           = 0,                                                               -- force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable)
    modal_parent_blocking   = true,                                                            -- whether parent windows of modals will be interactive
    locale                  = [[]],                                                            -- overrides the system locale (e.g. "en_US", "es")
  },
})
