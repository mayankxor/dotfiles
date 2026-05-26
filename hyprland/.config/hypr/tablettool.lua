-- https://wiki.hypr.land/Configuring/Basics/Variables/#tablettool
hl.config({
  input = {
    tablettool = {
      eraser_button_mode = 0,     -- Change the eraser button behavior on the tool. When set to 0, use the default hardware behavior of the tool. When set to 1, the eraser button on the tool sends a button event instead.
      eraser_button_override = 0, -- Set a button to be button event when eraser_button_mode is set to 1. Has to be an int, cannot be a string. Must be a valid button (e.g. BTN_STYLUS) excluding fake buttons (e.g. BTN_TOOL_) and keys (KEY_). Check wev if you have any doubts regarding the ID. 0 means default.
      pressure_range_min = -1.0,  -- Set the minimum pressure range for the tool, a negative number will set the default minimum pressure value. This is usually 0.0
      pressure_range_max = -1.0,  -- Set the maximum pressure range for the tool, a negative number will set the default maximum pressure value. This is usually 1.0
    },
  },
})
