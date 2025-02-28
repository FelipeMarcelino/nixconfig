pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Miscellanous awesome library
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey

-- Error handling
require("main.error-handling")

-- Custom Local Library
local main = {
	layouts = require("main.layouts"),
	tags = require("main.tags"),
	menu = require("main.menu"),
	rules = require("main.rules"),
	signals = require("main.signals"),
}

RC.layouts = main.layouts()
RC.tags = main.tags()
RC.mainmenu = awful.menu({ items = main.menu() })
RC.launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = RC.mainmenu })
menubar.utils.terminal = RC.vars.terminal
awful.rules.rules = main.rules(clientkeys, clientbuttons)
