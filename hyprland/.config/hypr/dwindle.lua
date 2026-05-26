-- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/#config

-- INFO:
-- Dwindle splits are NOT PERMANENT. The split is determined dynamically with the W/H ratio of the parent node. If W > H, it’s side-by-side. If H > W, it’s top-and-bottom. You can make them permanent by enabling preserve_split.

hl.config({
  dwindle = {
    force_split = 0,                      -- 0 -> split follows mouse, 1 -> always split to the left (new = left or top) 2 -> always split to the right (new = right or bottom)
    preserve_split = false,               -- If enabled, the split (side/top) will not change regardless of what happens to the container.
    smart_split = false,                  -- if enabled, allows a more precise control over the window split direction based on the cursor’s position. The window is conceptually divided into four triangles, and cursor’s triangle determines the split direction. This feature also turns on preserve_split.
    smart_resizing = true,                -- If enabled, resizing direction will be determined by the mouse's position on the window (nearest to which corner). Else, it is based on the window's tiling position.
    permanent_direction_override = false, -- if enabled, makes the preselect direction persist until either this mode is turned off, another direction is specified, or a non-direction is specified (anything other than l,r,u/t,d/b)
    special_scale_factor = 1,             -- Specifies the scale factor of windows on the special workspace [0 - 1]
    split_width_multiplier = 1.0,         -- Specifies the auto-split width multiplier. Multiplyig window size is useful on widescreen monitors where window W > H even after several splits.
    use_active_for_splits = true,         -- Whether to prefer the active window or the mouse position for splits.
    default_split_ratio = 1.0,            -- The default split ratio on window open. 1 means even 50/50 split. [0-1 - 0-9]
    split_bias = 0,                       -- Specifies which window will receive the split ratio. 0 -> directional (the top or left window), 1 -> the current window.
    precise_mouse_move = false,           -- Bindm movewindow will drop the window more precisely depending on where your mouse is.
  }
})
