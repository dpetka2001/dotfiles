return {
  -- { "LazyVim/LazyVim", opts = {
  --   colorscheme = "tokyonight",
  -- } },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      on_highlights = function(hl, c)
        hl.NavicIconsFile = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsModule = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsNamespace = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsPackage = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsClass = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsMethod = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsProperty = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsField = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsConstructor = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsEnum = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsInterface = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsFunction = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsVariable = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsConstant = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsString = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsNumber = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsBoolean = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsArray = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsObject = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsKey = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsNull = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsEnumMember = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsStruct = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsEvent = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsOperator = { bg = c.bg_dark, fg = c.fg }
        hl.NavicIconsTypeParameter = { bg = c.bg_dark, fg = c.fg }
        hl.NavicText = { bg = c.bg_dark, fg = c.fg }
        hl.NavicSeparator = { bg = c.bg_dark, fg = c.fg }
      end,
    },
  },
  { "catppuccin/nvim", name = "catppuccin" },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", event = "VeryLazy" },

  -- Colorizer for showing colors from RBG values
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },
}
