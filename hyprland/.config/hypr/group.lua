-- https://wiki.hypr.land/Configuring/Basics/Variables/#group

hl.config({
  group = {
    auto_group = true,                            -- whether new windows will be automatically grouped into the focused unlocked group. Note: if you want to disable auto_group only for specific windows, use the “group barred” window rule instead. https://wiki.hypr.land/Configuring/Basics/Window-Rules/#group-window-rule-options
    insert_after_current = true,                  -- Whether new windows in a group spawn after current or at group tail
    focus_removed_window = true,                  -- Whether Hyprland should focus on the window that has just been moved out of the group
    drag_into_group = 1,                          -- Whether dragging a window into a unlocked group will merge them. Options: 0 (disabled), 1 (enabled), 2 (only when dragging into the groupbar)
    merge_groups_on_drag = true,                  -- Whether window groups can be dragged into other groups
    merge_groups_on_groupbar = true,              -- Whether one group will be merged with another when dragged into its groupbar
    merge_floated_into_tiled_on_groupbar = false, -- Whether dragging a floating window into a tiled window groupbar will merge them
    group_on_movetoworkspace = false,             -- Whether using movetoworkspace[silent] will merge the window into the workspace's solitary unlocked group
    col = {
      border_active = 0x66ffff00,                 -- active group border color
      border_inactive = 0x66777700,               -- inactive (out of focus) group border color
      border_locked_active = 0x66ff5500,          -- active locked group border color
      border_locked_inactive = 0x66775500,        -- inactive locked group border color
    },
  },
})
