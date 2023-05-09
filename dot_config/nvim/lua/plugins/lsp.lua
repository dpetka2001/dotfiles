return {
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
      keys[#keys + 1] = {
        "K",
        function()
          require("pretty_hover").hover()
        end,
        desc = "Hover",
      }

      require("which-key").register({
        ["<leader>cl"] = { name = "+lsp" },
      })
    end,
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = "icons",
        },
      },
    },
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        lazy = true,
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
        keys = {
          { "<leader>cln", "<cmd>Navbuddy<cr>", desc = "Lsp Navigation" },
        },
      },

      -- Show symbols in a tree for LSP
      {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        keys = {
          { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
        },
        opts = {
          width = 35,
        },
      },

      -- Pretty hover
      {
        "Fildo7525/pretty_hover",
        event = "LspAttach",
        opts = {},
      },
    },
  },

  -- Import extra lsp languages configs
  { import = "plugins.extras.lang" },
}
