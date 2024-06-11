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

  LazyVim.pick("colorscheme", { enable_preview = true })()
  vim.fn.getcompletion = target
end

return {
  -- { "LazyVim/LazyVim", opts = {
  --   colorscheme = "tokyonight",
  -- } },
  {
    "folke/tokyonight.nvim",
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme with preview" },
    },
    opts = {
      style = "moon",
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
