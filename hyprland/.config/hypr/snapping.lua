hl.config({
  general = {
    -- https://wiki.hypr.land/Configuring/Basics/Variables/#snap
    snap = {
      enabled = false,        -- enable snapping for floating windows
      window_gap = 10,        -- minimum gap in pixels between windows before snapping
      monitor_gap = 10,       -- minimum gap in pixels between window and monitor edges before snapping
      border_overlap = false, -- if true, windows snap such that only one border's worth of space is between them
      respect_gaps = false,   -- if true, snapping will respect gaps between windows(set in general:gaps_in)
    },
  }
})
