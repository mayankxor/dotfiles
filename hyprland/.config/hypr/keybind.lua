local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local layout = hl.get_config("general.layout")

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(TERMINAL))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + Q",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(FILEMANAGER))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(BROWSER))
-- hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1, action = "toggle" }))
hl.bind(mainMod .. " + M", function()
  if layout == "dwindle" then
    hl.dispatch(hl.dsp.window.fullscreen({ mode = 1, action = "toggle" }))
  elseif layout == "master" then
    hl.dispatch(hl.dsp.layout("mfact exact 1.0"))
  elseif layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("fit visible"))
  end
end)
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(MENU))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprlock"))

-- hl.bind(mainMod .. " + Y", hl.dsp.window.pseudo(splitratio = 0.1))
-- hl.bind(mainMod .. " + UP", hl.dsp.layout("splitratio -0.01"))
hl.bind(mainMod .. " + LEFT", function()
  if layout == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio -0.01"))
  elseif layout == "master" then
    hl.dispatch(hl.dsp.layout("mfact -0.01"))
  elseif layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("colresize -0.01"))
  end
end)

hl.bind(mainMod .. " + RIGHT", function()
  if layout == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio +0.01"))
  elseif layout == "master" then
    hl.dispatch(hl.dsp.layout("mfact +0.01"))
  elseif layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("colresize +0.01"))
  end
end)

hl.bind(mainMod .. " + SHIFT + LEFT", function()
  if layout == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio -0.1"))
  elseif layout == "master" then
    hl.dispatch(hl.dsp.layout("mfact -0.1"))
  elseif layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("colresize -0.1"))
  end
end)

hl.bind(mainMod .. " + SHIFT + RIGHT", function()
  if layout == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio +0.1"))
  elseif layout == "master" then
    hl.dispatch(hl.dsp.layout("mfact +0.1"))
  elseif layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("colresize +0.1"))
  end
end)
hl.bind(mainMod .. " + UP", hl.dsp.layout("splitratio -0.01"))
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.layout("splitratio -0.1"))
hl.bind(mainMod .. " + DOWN", hl.dsp.layout("splitratio 0.01"))
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.layout("splitratio 0.1"))
hl.bind(mainMod .. " + RETURN", hl.dsp.layout("rotatesplit 180"))
hl.bind(mainMod .. " + SHIFT + R", function()
  if layout == "dwindle" then
    hl.dispatch(hl.dsp.layout("movetoroot"))
  elseif layout == "master" then
    hl.dispatch(hl.dsp.layout("swapwithmaster ignoremaster"))
  end
end)
hl.bind(mainMod .. " + E", function()
  if layout == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio 1 exact"))
  elseif layout == "master" then
    local default = hl.get_config("master.mfact")
    hl.dispatch(hl.dsp.layout("mfact exact " .. default))
  elseif layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("fit visible"))
  end
end)
hl.bind(mainMod .. " + I", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + D", hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("orientationcycle"))

-- hl.bind(mainMod .. " + RETURN", hl.dsp.layout("togglesplit")) -- dwindle only, preserve_splits must be enabled

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + L", function()
  if layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("focus right"))
  else
    hl.dispatch(hl.dsp.focus({ direction = "right" }))
  end
end)
hl.bind(mainMod .. " + H", function()
  if layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("focus left"))
  else
    hl.dispatch(hl.dsp.focus({ direction = "left" }))
  end
end)
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
