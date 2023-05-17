--local awful = require("awful")
--local gears = require("gears")
local term = "kitty"

myRules = {
	-- Set terminal to always map on the tag named "2" on screen 1.
	{
		rule = { class = term },
		properties = { screen = 1, tag = "term", switchtotag = true },
	},
	{
		rule_any = { name = { "Private" } },
		properties = { screen = 1, tag = "misc", switchtotag = true },
	},
	{
		-- rule_any = { class = { "firefox" } },
		rule_any = { name = { "Mozilla Firefox" } },
		except_any = { name = { "Browsing", "Firefox Developer Edition" } },
		properties = { screen = 1, tag = "www", switchtotag = true },
	},
}

return myRules
