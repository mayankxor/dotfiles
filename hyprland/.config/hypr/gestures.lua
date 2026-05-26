-- https://wiki.hypr.land/Configuring/Basics/Variables/#gestures
-- NOTE: workspace_swipe, workspace_swipe_fingers and workspace_swipe_min_fingers were removed in favor of the new gestures system.
-- You can add this gesture config to replicate the swiping functionality with 3 fingers. See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures for more info.
--
-- Example:
-- hl.gesture({
--    fingers = 3,
--    direction = "horizontal",
--    action = "workspace"
-- })

hl.config({
  gestures = {
    workspace_swipe_distance = 300,          -- in px, the distance of the touchpad gesture
    workspace_swipe_touch = false,           -- enable workspace swiping from the edge of a touchscreen
    workspace_swipe_invert = true,           -- invert the direction (touchpad only)
    workspace_swipe_touch_invert = false,    -- invert the direction (touchscreen only)
    workspace_swipe_min_speed_to_force = 30, -- minimum speed in px per timepoint to force the change ignoring `cancel_ratio`. Setting to 0 will disable this mechanic.
    workspace_swipe_cancel_ratio = 0.5,      -- how much the swipe has to proceed in order to commence it. (0.7 -> if > 0.7 * distance, switch, if less, revert) [0.0 - 1.0]
    workspace_swipe_create_new = true,       -- whether a swipe right on the last workspace should create a new one.
    workspace_swipe_direction_lock = true,   -- if enabled, switching direction will be locked when you swipe past the `direction_lock_threshold` (touchpad only).
    workspace_swipe_forever = false,         -- if enabled, swiping will not clamp at the neighbouring workspaces but continue to further ones.
    workspace_swipe_use_r = false,           -- if enabled, swiping will use the `r` prefix instead of the `m` prefix for finding workspaces.
    close_max_timeout = 1000,                -- the timeout for a window to close when using a 1:1 gesture, in ms
  }
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})
