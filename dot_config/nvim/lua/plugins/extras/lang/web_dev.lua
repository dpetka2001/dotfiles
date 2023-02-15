return {
  -- Add ``lang`` to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css",
        "javascript",
        "typescript",
        "json",
        "lua",
        "bash",
        "markdown",
      })
    end,
  },

  -- Add ``server`` and ``formatter`` to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "html-lsp",
        "typescript-language-server",
        "css-lsp",
        "tailwindcss-language-server",
        "stylelint-lsp",
        "eslint-lsp",
        "prettier",
      })
    end,
  },

  -- Setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        tsserver = function(_, opts)
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            end
          end)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },

  -- Setup null-ls with ``formatter``
  -- {
  --     "jose-elias-alvarez/null-ls.nvim",
  --     opts = function(_, opts)
  --       local nls = require("null-ls")
  --       opts.sources = vim.list_extend(opts.sources, { nls.builtins.formatting.`formatter` })
  --     end,
  --   },
}
