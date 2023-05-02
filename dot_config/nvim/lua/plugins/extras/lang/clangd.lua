return {
  -- Add `c` and `cpp` to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c", "cpp" })
    end,
  },

  -- Add `clangd` and `clang_format` to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "clangd", "clang-format" })
    end,
  },

  -- Setup DAP ``adapter``
  -- {
  --   "mason-nvim-dap.nvim",
  --   opts = {
  --     ensure_installed = { "`adapter`" },
  --   },
  -- },

  -- Setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "p00f/clangd_extensions.nvim",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
      },
    },
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
          opts.cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
          }
          opts.init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          }
          require("clangd_extensions").setup({
            server = opts,
            extensions = {
              ast = {
                --These require codicons (https://github.com/microsoft/vscode-codicons)
                role_icons = {
                  type = "",
                  declaration = "",
                  expression = "",
                  specifier = "",
                  statement = "",
                  ["template argument"] = "",
                },
                kind_icons = {
                  Compound = "",
                  Recovery = "",
                  TranslationUnit = "",
                  PackExpansion = "",
                  TemplateTypeParm = "",
                  TemplateTemplateParm = "",
                  TemplateParamObject = "",
                },
              },
            },
          })
          return true
        end,
      },
    },
  },

  -- Setup null-ls with `clang_format`
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.clang_format.with({
          extra_args = {
            "-style=file:" .. vim.fn.expand("~/Desktop/Projects/C/.clang-format"),
          },
        }),
      })
    end,
  },
}
