-- https://wiki.hypr.land/Configuring/Basics/Variables/#quirks

-- INFO: Some clients expect monitor to be in HDR mode prior to the client start. This breaks auto HDR activation and can cause whitescreen and flickering. Use `prefer_hdr` to fix.

hl.config({
  quirks = {
    prefer_hdr = 0, -- Report HDR mode as preferred. 0 - off, 1 - always, 2 - gamescope only
  }
})
