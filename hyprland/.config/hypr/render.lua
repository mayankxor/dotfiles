-- https://wiki.hypr.land/Configuring/Basics/Variables/#render

-- INFO:
-- cm_auto_hdr requires --target-colorspace-hint-mode=source mpv option to work with mpv versions greater than v0.40.0

hl.config({
  render = {
    direct_scanout = 0,                -- Enables direct scanout. Direct scanout attempts to reduce lag when there is only one fullscreen application on a screen (e.g. game). It is also recommended to set this to false if the fullscreen application shows graphical glitches. 0 - off, 1 - on, 2 - auto (on with content type ‘game’)
    expand_undersized_textures = true, -- Whether to expand undersized textures along the edge, or rather stretch the entire texture.
    xp_mode = false,                   -- Disables back buffer and bottom layer rendering.
    ctm_animation = 2,                 -- Whether to enable a fade animation for CTM changes (hyprsunset). 2 means "auto" which disables them on nvidia.
    cm_enabled = true,                 -- Whether the color management pipeline should be enabled or not (requires a restart of Hyprland to fully take effect)
    send_content_type = true,          -- Report content type to allow monitor profile autoswitch (may result in a black screen during the switch)
    cm_auto_hdr = 1,                   -- Auto-switch to HDR in fullscreen when needed. 0 - off, 1 - switch to `cm, hdr`, 2 - switch to `cm, hdredid`
    new_render_scheduling = false,     -- Automatically uses triple buffering when needed, improves FPS on underpowered devices.
    non_shader_cm = 2,                 -- Enable CM without shader. 0 - disable, 1 - whenever possible, 2 - DS and passthrough only, 3 - disable and ignore CM issues.
    non_shader_cm_interop = 2,         -- 0 - external ctm (hyprsunset, etc) is disabled in fullscreen, 1 - external ctm is enabled in fullscreen, 2 - external ctm is disabled for fullscreen photo/video/game content types.
    cm_sdr_eotf = "default",           -- Default transfer function for displaying SDR apps. "default" - Use default value(sRGB), "gamma22" - Treat unspecified and sRGB as Gamma 2.2, "srgb" - Treat unspecified as sRGB.
    commit_timing_enabled = true,      -- Enable commit timing proto. Requires restart.
    use_fp16 = 2,                      -- Use FP16 buffers internally. 0 - disabled, 1 - enabled, 2 - enabled in hdr mode.
    keep_unmodified_copy = 2,          -- Keep unmodified SDR frame copy for screensharing. 0 - disabled, 1 - on, 2 - auto (enabled in HDR with SDR modifiers). Set to 1 if screenshots are transparent.
    use_shader_blur_blend = false,     -- Use experimental blurring bg blending (glitched on rotated screens). Set to true if blur is missing with fp16 or keep_unmodified_copy
  }
})
