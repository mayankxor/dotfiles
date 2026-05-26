-- https://wiki.hypr.land/Configuring/Basics/Variables/#debug

hl.config({
  debug = {
    overlay = false,              -- Print the debug performance overlay. Disable VFR for accurate results.
    damage_blink = false,         -- (epilepsy warning!) flash area updated with damage tracking.
    gl_debugging = false,         -- enables OpenGL debugging with glGetError and EGL_KHR_debug, requires a restart after changing.
    vfr = true,                   -- controls the VFR status of Hyprland. Heavily recommended to leave enabled to conserve resources.
    disable_logs = true,          -- Disable logging to a file.
    disable_time = true,          -- Disable time logging.
    damage_tracking = 2,          -- Redraw only the needed bits of the display. Do not change. (default: full - 2), monitor - 1, none - 0
    enable_stdout_logs = false,   -- Enables logging to stdout.
    manual_crash = 0,             -- Set to 1 and back to 0 to crash hyprland.
    suppress_errors = false,      -- If true, do not display config file parsing erros.
    watchdog_timeout = 5,         -- Sets the timeout in seconds for watchdog to abort processing of a signal of the main thread. Set to 0 to disable.
    disable_scale_checks = false, -- Disables verification of the scale factors. Will result in pixel alignment and rounding errors.
    error_limit = 5,              -- Limits the number of displayed config file parsing errors.
    error_position = 0,           -- Sets the position of the error bar. top - 0, bottom - 1
    colored_stdout_logs = true,   -- Enables colors in the stdout logs.
    pass = false,                 -- Enables render pass debugging.
    full_cm_proto = false,        -- Claims support for all cm proto features (requires restart)
    invalidate_fp16 = 2,          -- Allow fp16 buffer invalidation (invalidation increases performance but produces glitches on some systems). 0 - not allowed, 1 - allowed, 2 - not allowed on nvidida
  }
})
