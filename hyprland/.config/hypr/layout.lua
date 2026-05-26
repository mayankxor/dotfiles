-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout

hl.config({
  general = {
    layout = "dwindle", -- which layout to use. ["dwindle"/"master"/"scrolling"/"monocle"]
  },
  layout = {
    single_window_aspect_ratio = { 0, 0 },      -- Whenever only a single window is shown on a screen, add padding so that it conforms to the specified aspect ratio. A value like {4, 3} on a {16, 9} screen will make it a 4:3 window in the middle with padding to the sides.
    single_window_aspect_ratio_tolerance = 0.1, -- Sets a tolerance for `single_window_aspect_ratio`, so that if the padding that would have been added is smaller than the specified fraction of the height or width of the screen, it will not attempt to adjust the window size [0 - 1]
  }
})
