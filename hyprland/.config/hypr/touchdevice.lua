-- https://wiki.hypr.land/Configuring/Basics/Variables/#touchdevice
hl.config({
  input = {
    touchdevice = {
      transform = -1,  -- Transform the input from touchdevices. The possible transformations are the same as those of the monitors. -1 means it’s unset.
      output = "Auto", -- The monitor to bind touch devices. The default is auto-detection. To stop auto-detection, use an empty string.
      enabled = true,  -- Whether input is enabled for touch devices.
    }
  }
})
