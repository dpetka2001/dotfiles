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

  -- Install fidget for LSP server progress visualization
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

  -- Customize LSP to start for new files
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
  },

  -- Also add null-ls to start for new files
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre" },
  },

  -- Import some lsp configs
  { import = "plugins.extras.lang.python" },
}
