return {
  -- Show symbols in a tree for LSP
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
    },
    opts = {
      width = 35,
    },
  },

  -- Import some lsp configs
  { import = "plugins.extras.lang.python" },
}
