local util = require("util")

return {
  -- Add ``lang`` to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, {
        "css",
        "php",
      })
    end,
  },

  -- Add ``server`` and ``formatter`` to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        --[[Servers]]
        --[[Formatters]]
        "prettierd",
        -- "prettier",
      })
    end,
  },

  -- Setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        -- tsserver = {
        --   root_dir = function(...)
        --     return require("lspconfig.util").root_pattern(".git")(...)
        --   end,
        -- },
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        stylelint_lsp = {}, -- css linter
        eslint = {},
        intelephense = {},
        emmet_language_server = {},
      },
      setup = {
        -- tsserver = function(_, opts)
        --   require("lazyvim.util").on_attach(function(client, buffer)
        --     if client.name == "tsserver" then
        --       client.server_capabilities.documentFormattingProvider = false
        --       -- stylua: ignore
        --       vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
        --       -- stylua: ignore
        --       vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
        --     end
        --     -- if client.name == "eslint" then
        --     --   client.server_capabilities.documentFormattingProvider = true
        --     -- end
        --   end)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
      },
    },
  },

  -- Setup up format with new `conform.nvim`
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["javascript"] = { { "prettierd", "prettier" } },
        ["javascriptreact"] = { { "prettierd", "prettier" } },
        ["typescript"] = { { "prettierd", "prettier" } },
        ["typescriptreact"] = { { "prettierd", "prettier" } },
        ["html"] = { { "prettierd", "prettier" } },
        ["css"] = { { "prettierd", "prettier" } },
      },
    },
  },

  -- Setup null-ls with `prettierd`
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = vim.list_extend(opts.sources, {
  --       nls.builtins.formatting.prettierd,
  --       nls.builtins.code_actions.eslint,
  --       -- nls.builtins.formatting.prettierd.with({
  --       --   filetypes = { "html", "css", "json", "jsonc", "yaml", "markdown" },
  --       -- }),
  --     })
  --   end,
  -- },

  -- Native TSServer client
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPost *.ts,*.tsx,*.js,*.jsx", "BufNewFile *.ts,*.tsx,*.js,*.jsx" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-lspconfig" },
    opts = {
      -- capabilities = require("lsp").client_capabilities(),
      -- on_attach = require("lsp").on_attach,
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "literals",
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },

  -- DAP for TS/JS
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")

          dapui.setup(opts)

          -- Hide the fold column.
          -- vim.api.nvim_create_autocmd("FileType", {
          --   pattern = { "dapui_scopes", "dapui_stacks", "dapui_breakpoints" },
          --   callback = function()
          --     require("ufo").detach()
          --   end,
          -- })

          -- Automatically open the UI when a new debug session is created.
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        opts = {
          debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
          adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        },
      },
      {
        "microsoft/vscode-js-debug",
        version = "1.x",
        build = "npm i && npm run compile vsDebugServerBundle && mv -f dist out",
      },
    },
    opts = function()
      local dap = require("dap")
      for _, language in ipairs({ "typescript", "javascript" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
              resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
              },
              outFiles = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
              },
              skipFiles = { "**/node_modules/**" },
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
              },
              outFiles = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
              },
              skipFiles = { "**/node_modules/**" },
            },
          }
        end
      end
    end,
  },
}
