-- https://wiki.hypr.land/Configuring/Basics/Variables/#xwayland

hl.config({
  xwayland = {
    enabled = true,                 -- Allow running applications using X11
    use_nearest_neighbor = true,    -- Uses the nearest neighbor filtering for xwayland apps, maknig them pixelated rather than blurry
    force_zero_scaling = false,     -- forces a scale of 1 on xwayland windows on scaled displays.
    create_abstract_socket = false, -- Create the abstract Unix domain socket (https://wiki.hypr.land/Configuring/Advanced-and-Cool/XWayland/#abstract-unix-domain-socket) for XWayland connections. (XWayland restart is required for changes to take effect; Linux only)
  }
})
