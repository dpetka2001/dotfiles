--local awful = require("awful")
--local gears = require("gears")
local term = "kitty"

myRules = {
-- Set terminal to always map on the tag named "2" on screen 1.
{ rule = { class = term },
    properties = { screen = 1, tag = "2", switchtotag = true } },
{ rule = { instance = "Navigator", class = "firefox" },
    properties = { screen = 1, tag = "1", switchtotag = true } },
}

return myRules
