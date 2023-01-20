if not pcall(require, "colorbuddy") then
  return
end

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("LspReferenceText", nil, c.gray0:light(), s.bold)
Group.new("LspReferenceWrite", nil, c.gray0:light())
Group.new("LspReferenceRead", nil, c.gray0:light())
