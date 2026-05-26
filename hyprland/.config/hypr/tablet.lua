-- https://wiki.hypr.land/Configuring/Basics/Variables/#tablet
hl.config({
  input = {
    tablet = {
      transform = -1,                   -- transform the input from tablets. The possible transformations are the same as those of the monitors. -1 means it’s unset.
      output = "",                      -- the monitor to bind tablets. Can be "current" or a monitor name. Leave empty to map across all monitors.
      region_position = { 0, 0 },       -- position of the mapped region in monitor layout relative to the top left corner of the bound monitor or all monitors.
      absolute_region_position = false, -- whether to treat the `region_position` as an absolute position in monitor layout. Only applies when `output` is empty.
      region_size = { 0, 0 },           -- size of the mapped region. When this variable is set, tablet input will be mapped to the region. {0, 0} or invalid size means unset.
      relative_input = false,           -- whether the input should be relative
      left_handed = false,              -- if enabled, the tablet will be rotated 180 degrees
      active_area_size = { 0, 0 },      -- size of tablet's active area in mm
      active_area_position = { 0, 0 },  -- position of the active area in mm
    },
  },
})
