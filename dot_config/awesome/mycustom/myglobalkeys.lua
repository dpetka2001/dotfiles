local gears = require("gears")
local awful = require("awful")

local vars = require("mycustom.vars")

-- Table to be returned and merged with default awesome key bindings.
globalKeys = gears.table.join(
	-- My custom program key bindings
	-- awful.key({ modkey,           }, "f", function () awful.spawn('firefox') end,
	awful.key({ modkey }, "f", function()
		awful.spawn("brave-browser-nightly")
	end, { description = "open firefox", group = "custom" }),

	-- My logout popup menu
	awful.key({ "Ctrl", "Mod1" }, "Delete", function()
		vars.launch()
	end, { description = "Show logout screen", group = "custom" }),

	-- Use Alt-Tab to go to next client
	awful.key({ "Mod1" }, "Tab", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),

	-- Brightness
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.util.spawn("sudo light -s sysfs/backlight/intel_backlight -U 5")
	end),
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.util.spawn("sudo light -s sysfs/backlight/intel_backlight -A 5")
	end),

	-- Sound Volume
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.util.spawn("amixer sset Master 1%+", false)
	end),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.util.spawn("amixer sset Master 1%-", false)
	end),
	awful.key({}, "XF86AudioMute", function()
		awful.util.spawn("amixer -D pulse set Master toggle", false)
	end)
)

return globalKeys
