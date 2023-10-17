---@diagnostic disable: missing-fields
return {
  -- Customize LSP
  {
    "neovim/nvim-lspconfig",
    -- Add, change or remove keymaps
    init = function()
      -- disable lsp watcher. Too slow on linux
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
        wf._watchfunc = function()
          return function() end
        end
      end

      --[[Modify LSP keymaps]]
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "gD", false }
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
      -- keys[#keys + 1] = {
      --   "K",
      --   function()
      --     require("pretty_hover").hover()
      --   end,
      --   desc = "Hover",
      -- }

      require("which-key").register({
        ["<leader>cl"] = { name = "+lsp" },
      })
    end,
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = "icons",
          spacing = 4,
          source = "if_many",
        },
        -- virtual_text = false,
      },
      inlay_hints = {
        -- enabled = true,
      },
      servers = {
        yamlls = {},
        -- tsserver = {
        --   -- Need to disable this cuz `Inline Edit` won't work otherwise
        --   single_file_support = false,
        --   settings = {
        --     typescript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = "literal",
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = false,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --     javascript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = "all",
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = true,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --   },
        -- },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- disable = { "missing-parameter" },
              },
              hint = {
                enable = true,
                setType = true,
                paramType = true,
                paramName = "All",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
    },
    dependencies = {
      -- {
      --   "SmiteshP/nvim-navbuddy",
      --   lazy = true,
      --   dependencies = {
      --     "SmiteshP/nvim-navic",
      --     "MunifTanjim/nui.nvim",
      --   },
      --   opts = { lsp = { auto_attach = true } },
      --   keys = {
      --     { "<leader>cln", "<cmd>Navbuddy<cr>", desc = "Lsp Navigation" },
      --   },
      -- },

      -- {
      --   "simrat39/symbols-outline.nvim",
      --   lazy = true,
      --   keys = {
      --     { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
      --   },
      --   opts = {
      --     width = 35,
      --     autofold_depth = 2,
      --   },
      -- },

      -- Pretty hover
      -- {
      --   "Fildo7525/pretty_hover",
      --   event = "LspAttach",
      --   opts = {},
      -- },
    },
  },

  -- Modify `null-ls`
  -- {
  --   "nvimtools/none-ls.nvim",
  --   init = function()
  --     vim.api.nvim_create_autocmd("LspAttach", {
  --       callback = function(args)
  --         local bufnr = args.buf
  --         local client = vim.lsp.get_client_by_id(args.data.client_id)
  --         if client.name == "null-ls" then
  --           vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cn", "<cmd>NullLsInfo<cr>", { desc = "NullLs Info" })
  --         end
  --       end,
  --     })
  --   end,
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = vim.list_extend(opts.sources, {
  --       nls.builtins.code_actions.gitsigns,
  --     })
  --   end,
  -- },

  -- Import extra lsp languages configs
  { import = "plugins.extras.lang" },
}
