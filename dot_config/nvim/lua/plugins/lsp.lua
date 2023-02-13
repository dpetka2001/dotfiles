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
    -- Add, change or remove keymaps
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "cwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", desc = "Remove workspace" }
      keys[#keys + 1] = { "cwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", desc = "Add workspace" }
      keys[#keys + 1] =
        { "cwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", desc = "List workspace" }
    end,
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
