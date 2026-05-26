-- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/#config

-- INFO:
-- The master layout makes one (or more) window(s) be the “master”, taking (by default) the left part of the screen, and tiles the rest on the right. You can change the orientation on a per-workspace basis if you want to use anything other than the default left/right split.

hl.config({
  master = {
    allow_small_split = false,         -- Enable adding additional master window in a horizontal split style.
    special_scale_factor = 0.1,        -- The scale of the special workspace windows. [0.0 - 1.0]
    mfact = 0.55,                      -- The size as a percentage of the master window, for example `mfact = 0.70` would mean 70% of the screen will be the master window, and 30% the slave [0.0 - 1.0]
    new_status = "slave",              -- "master": new window becomes master "slave": new windows are added to slave stack "inherit": inherit from focused window
    new_on_top = false,                -- Whether a newly open window should be on the top of the stack.
    new_on_active = "none",            -- "before", "after": place new window relative to the focused window; "none": place new window according to the value of `new_on_top`
    orientation = "left",              -- Default placement of the master area, can be "left", "right", "top", "bottom" or "center"
    slave_count_for_center_master = 2, -- When using orientation = "center", make the master window centered only when atleast this many slave windows are open. (Set 0 to always_center_master)
    center_master_fallback = "left",   -- Set fallback for center master when slaves are less than `slave_count_for_center_master`, can be "left", "right", "top", "bottom"
    smart_resizing = true,             -- If enabled, resizing direction will be determined by the mouse's position on the window (nearest to which corner). Else, it is based on the window's tiling position.
    drop_at_cursor = false,            -- when enabled, dragging and dropping windows will put them at the cursor position. Otherwise, when dropped at the stack side, they will go to the top/bottom of the stack depending on new_on_top.
    always_keep_position = false,      -- Whether to keep the master window in its configured position when there are no slave windows.
    -- INTERESTING: Doesn't recognize
    -- focus_master_on_close = false,     -- When enabled, closing a window focuses the master window.
  }
})
