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
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>cli", "<cmd>LspInfo<cr>", desc = "LspInfo" }
      keys[#keys + 1] =
        { "<leader>clr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", desc = "Remove workspace" }
      keys[#keys + 1] = { "<leader>cla", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", desc = "Add workspace" }
      keys[#keys + 1] = {
        "<leader>cll",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        desc = "List workspace",
      }

      require("which-key").register({
        ["<leader>cl"] = { name = "+lsp" },
      })
    end,
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
        keys = {
          { "<leader>cln", "<cmd>Navbuddy<cr>", desc = "Lsp Navigation" },
        },
      },
    },
  },

  -- Import some lsp configs
  { import = "plugins.extras.lang.python" },
  { import = "plugins.extras.lang.web_dev" },
}
