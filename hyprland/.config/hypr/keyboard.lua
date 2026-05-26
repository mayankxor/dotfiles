hl.config({
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#input
  -- You can find a list of models, layouts, variants and options in /usr/share/X11/xkb/rules/evdev.lst. Alternatively, you can use the `localectl` command to discover what is available on your system.
  -- For switchable keyboard configurations, take a look at the binds page entry(https://wiki.hypr.land/Configuring/Basics/Binds/#switchable-keyboard-layouts).
  input = {
    kb_model             = "",    -- Appropriate XKB keymap parameter.
    kb_layout            = "us",  -- Appropriate XKB keymap parameter.
    kb_variant           = "",    -- Appropriate XKB keymap parameter.
    kb_options           = "",    -- Appropriate XKB keymap parameter.
    kb_rules             = "",    -- Appropriate XKB keymap parameter.
    kb_file              = "",    -- If you prefer, you can use a path to your custom .xkb file
    numlock_by_default   = true,  -- Engage numlock by default
    resolve_binds_by_sym = false, -- Determines how keybinds act when multiple layouts are used. If false, keybinds will always act as if the first specified layout is active. If true, keybinds specified by symbols are activated when you type the respective symbol with the current layout.
    repeat_rate          = 25,    -- The repeat rate for held-down keys, in repeats per second.
    repeat_delay         = 600,   -- Delay before a held-down key is repeated, in milliseconds
  }
})
