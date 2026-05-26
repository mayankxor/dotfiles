-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/

-- INFO: Scrolling is a layout where windows get positioned on an infinitely growing tape.

hl.config({
  scrolling = {
    fullscreen_on_one_column = true,                -- When enabled, a single column on a workspace will always span the entire screen.
    column_width = 0.5,                             -- The default width of a column, [0.1 - 1.0]
    focus_fit_method = 1,                           -- When a column is focused, what method should be used to bring it into view. 0 = center, 1 = fit.
    follow_focus = true,                            -- When a window is focused, should the layout move to bring it into view automatically
    follow_min_visible = 0.4,                       -- When a window is focused, require that at least a given fraction of it is visible for focus to follow. Hard input (e.g. binds, clicks) will always follow. [0.0 - 1.0]
    explicit_column_widths = "0.333,0.5,0.667,1.0", -- 	A comma-separated list of preconfigured widths for colresize +conf/-conf
    wrap_focus = true,                              -- When enabled, causes `hl.dsp.layoutmsg("focus l/r")` to wrap around at the beginning and end.
    wrap_swapcol = true,                            -- When enabled, causes `hl.dsp.layoutmsg("swapcol l/r")` to wrap around at the beginning and end.
    direction = "right",                            -- Direction in which new window appears and the layout scrolls. ["left" / "right" / "down" / "up"]
  }
})
