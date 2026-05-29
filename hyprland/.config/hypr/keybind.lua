if hl.version() ~= "0.55.2" then
  hl.notification.create({
    text = "Using version " ..
        hl.version() .. ", config was written for 0.55.2, config may break."
  })
end
local mainMod = "SUPER" -- Sets "Window + ALT + s" key as main modifier
local resize_actions = {
  dwindle = function(delta)
    hl.dispatch(hl.dsp.layout("splitratio " .. delta))
  end,
  master = function(delta)
    hl.dispatch(hl.dsp.layout("mfact " .. delta))
  end,
  scrolling = function(delta)
    hl.dispatch(hl.dsp.layout("colresize " .. delta))
  end,
}
local function layout()
  return hl.get_config("general.layout")
end
local function resize(delta)
  if resize_actions[layout()] then
    resize_actions[layout()](delta)
  end
end

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(TERMINAL))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + Q",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(FILEMANAGER))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(BROWSER))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(MENU))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + RIGHT", function() resize("+0.01") end)
hl.bind(mainMod .. " + LEFT", function() resize("-0.01") end)
hl.bind(mainMod .. " + SHIFT + RIGHT", function() resize("+0.1") end)
hl.bind(mainMod .. " + SHIFT + LEFT", function() resize("-0.1") end)

hl.bind(mainMod .. " + UP", function()
  if layout() == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio -0.01"))
  end
end)
hl.bind(mainMod .. " + SHIFT + UP", function()
  if layout() == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio -0.1"))
  end
end)
hl.bind(mainMod .. " + DOWN", function()
  if layout() == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio +0.01"))
  end
end)
hl.bind(mainMod .. " + SHIFT + DOWN", function()
  if layout() == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio +0.1"))
  end
end)

hl.bind(mainMod .. " + RETURN", function()
  local layoutt = layout()
  if layoutt == "dwindle" then
    hl.dispatch(hl.dsp.layout("rotatesplit 180"))
  elseif layoutt == "master" then
    hl.dispatch(hl.dsp.layout("swapnext loop"))
  elseif layoutt == "scrolling" then
    hl.dispatch(hl.dsp.layout("swapcol r"))
  end
end)

hl.bind(mainMod .. " + ALT + RETURN", function()
  local layoutt = layout()
  if layoutt == "dwindle" then
    hl.dispatch(hl.dsp.layout("rotatesplit 180"))
  elseif layoutt == "master" then
    hl.dispatch(hl.dsp.layout("swapprev loop"))
  elseif layoutt == "scrolling" then
    hl.dispatch(hl.dsp.layout("swapcol l"))
  end
end)
hl.bind(mainMod .. " + SHIFT + R", function()
  local layoutt = layout()
  if layoutt == "dwindle" then
    hl.dispatch(hl.dsp.layout("movetoroot"))
  elseif layoutt == "master" then
    hl.dispatch(hl.dsp.layout("swapwithmaster ignoremaster"))
  elseif layoutt == "scrolling" then
    hl.dispatch(hl.dsp.layout("promote"))
  end
end)
hl.bind(mainMod .. " + E", function()
  local layoutt = layout()
  if layoutt == "dwindle" then
    hl.dispatch(hl.dsp.layout("splitratio 1 exact"))
  elseif layoutt == "master" then
    local default = hl.get_config("master.mfact")
    hl.dispatch(hl.dsp.layout("mfact exact " .. default))
  elseif layoutt == "scrolling" then
    hl.dispatch(hl.dsp.layout("fit visible"))
  end
end)
hl.bind(mainMod .. " + I", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + D", hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("orientationcycle"))

hl.bind(mainMod .. " + L", function()
  local layoutt = layout()
  if layoutt == "scrolling" then
    hl.dispatch(hl.dsp.layout("focus right"))
  elseif layoutt == "monocle" or layoutt == "master" then
    hl.dispatch(hl.dsp.layout("cyclenext"))
  else
    hl.dispatch(hl.dsp.focus({ direction = "right" }))
  end
end)
hl.bind(mainMod .. " + K", function()
  local layoutt = layout()
  if layoutt == "scrolling" then
    hl.dispatch(hl.dsp.layout("focus right"))
  elseif layoutt == "monocle" or layoutt == "master" then
    hl.dispatch(hl.dsp.layout("cyclenext"))
  else
    hl.dispatch(hl.dsp.focus({ direction = "up" }))
  end
end)
hl.bind(mainMod .. " + H", function()
  local layoutt = layout()
  if layoutt == "scrolling" then
    hl.dispatch(hl.dsp.layout("focus left"))
  elseif layoutt == "monocle" or layoutt == "master" then
    hl.dispatch(hl.dsp.layout("cycleprev"))
  else
    hl.dispatch(hl.dsp.focus({ direction = "left" }))
  end
end)
hl.bind(mainMod .. " + J", function()
  local layoutt = layout()
  if layoutt == "scrolling" then
    hl.dispatch(hl.dsp.layout("focus left"))
  elseif layoutt == "monocle" or layoutt == "master" then
    hl.dispatch(hl.dsp.layout("cycleprev"))
  else
    hl.dispatch(hl.dsp.focus({ direction = "down" }))
  end
end)

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
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Laptop multimedia keys for volume and LCD brightness
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
local function setLayout(name)
  hl.config({
    general = {
      layout = name
    }
  })
end
hl.bind(mainMod .. " + ALT + M", function() setLayout("monocle") end)
hl.bind(mainMod .. " + ALT + D", function() setLayout("dwindle") end)
hl.bind(mainMod .. " + ALT + N", function() setLayout("master") end)
hl.bind(mainMod .. " + ALT + S", function() setLayout("scrolling") end)
hl.bind("SUPER + X", function()
  hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
  hl.dispatch(hl.dsp.window.move({ workspace = "+0" }))
  hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
  hl.dispatch(hl.dsp.window.move({ workspace = "special:minimize" }))
  hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
end)
hl.bind(mainMod .. " + F1", function()
  local game_mode = (hl.get_config("animations.enabled") == false)
  if game_mode then
    hl.exec_cmd("hyprctl reload")
    return
  end
  hl.config({
    general    = {
      gaps_in = 0,
      gaps_out = 0,
      border_size = 2,
      col = {
        active_border = "#ff0000"
      }
    },
    animations = {
      enabled = false,
    },
    decoration = {
      shadow = { enabled = false, },
      blur = { enabled = false, },
      rounding = 0,
    }
  })
end)

hl.bind(mainMod .. " + tab", function()
  local layouts     = { "scrolling", "dwindle", "master", "monocle" }
  local workspace   = hl.get_active_workspace()
  local next_layout = "dwindle"

  if not workspace then
    return
  end

  for i = 1, #layouts do
    if layouts[i] == workspace.tiled_layout then
      local next_layout_idx = (i % #layouts) + 1
      next_layout = layouts[next_layout_idx]
      break
    end
  end

  hl.workspace_rule({ workspace = workspace.name, layout = next_layout })
  hl.notification.create({ text = "Workspace layout: " .. next_layout, timeout = 5000, color = "#00ff00" })
end)
hl.bind(mainMod .. " + SHIFT + G", function()
  hl.exec_cmd("hyprctl reload")
end)

local hourlytimer = hl.timer(function()
  hl.notification.create({ text = "Another hour passed", timeout = 10000, font_size = 20, })
end, { timeout = 3600000, type = "repeat" })
hourlytimer:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + T", function()
  if not hourlytimer:is_enabled() then
    hl.notification.create({ text = "A repeating timer for 1 hour has been started", timeout = 5000, icon = "info", font_size = 20, })
  else
    hl.notification.create({ text = "Timer stopped", timeout = 5000, icon = "info", font_size = 20, })
  end
  hourlytimer:set_enabled(not hourlytimer:is_enabled())
end)

hl.bind("PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/takescreenshot.sh"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/savescreenshot.sh"))
