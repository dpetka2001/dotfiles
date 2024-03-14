Util = require("lazyvim.util")

local get_colorsheme = function()
  local builtins = {}

  for name, _ in vim.fs.dir("$VIMRUNTIME/colors/") do
    if name:match("*.txt") then
      break
    else
      name = name:match("(.*).lua$") or name:match("(.*).vim$")
      table.insert(builtins, name)
    end
  end
  local target = vim.fn.getcompletion

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.getcompletion = function()
    return vim.tbl_filter(function(color)
      return not vim.tbl_contains(builtins, color)
      ---@diagnostic disable-next-line: param-type-mismatch
    end, target("", "color"))
  end

  Util.telescope("colorscheme", { enable_preview = true })()
  vim.fn.getcompletion = target
end

return {
  -- { "LazyVim/LazyVim", opts = {
  --   colorscheme = "tokyonight",
  -- } },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      on_highlights = function(hl, c)
        hl.NavicIconsFile = { fg = c.fg, bg = c.bg_dark }
        hl.NavicIconsModule = { fg = c.yellow, bg = c.bg_dark }
        hl.NavicIconsNamespace = { fg = c.fg, bg = c.bg_dark }
        hl.NavicIconsPackage = { fg = c.fg, bg = c.bg_dark }
        hl.NavicIconsClass = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsMethod = { fg = c.blue, bg = c.bg_dark }
        hl.NavicIconsProperty = { fg = c.green1, bg = c.bg_dark }
        hl.NavicIconsField = { fg = c.green1, bg = c.bg_dark }
        hl.NavicIconsConstructor = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsEnum = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsInterface = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsFunction = { fg = c.blue, bg = c.bg_dark }
        hl.NavicIconsVariable = { fg = c.magenta, bg = c.bg_dark }
        hl.NavicIconsConstant = { fg = c.magenta, bg = c.bg_dark }
        hl.NavicIconsString = { fg = c.green, bg = c.bg_dark }
        hl.NavicIconsNumber = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsBoolean = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsArray = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsObject = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsKey = { fg = c.purple, bg = c.bg_dark }
        hl.NavicIconsKeyword = { fg = c.purple, bg = c.bg_dark }
        hl.NavicIconsNull = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsEnumMember = { fg = c.green1, bg = c.bg_dark }
        hl.NavicIconsStruct = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsEvent = { fg = c.orange, bg = c.bg_dark }
        hl.NavicIconsOperator = { fg = c.fg, bg = c.bg_dark }
        hl.NavicIconsTypeParameter = { fg = c.green1, bg = c.bg_dark }
        hl.NavicText = { fg = c.fg, bg = c.bg_dark }
        hl.NavicSeparator = { fg = c.fg, bg = c.bg_dark }
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme with preview" },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme with preview" },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme with preview" },
    },
  },
}
