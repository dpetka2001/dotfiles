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

  -- Customize LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "j-hui/fidget.nvim",
        opts = {
          text = {
            spinner = "moon",
          },
          window = {
            relative = "editor",
          },
        },
      },
    },
  },

  -- Import some lsp configs
  { import = "plugins.extras.lang.python" },
}
