local beautiful = require("beautiful")
local mymainmenu = require("menu")
local awful = require("awful")
return awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
})
