local util = require("util")

return {
  -- Add `c` and `cpp` to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "c", "cpp" })
    end,
  },

  -- Add `tools` to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "clang-format" })
    end,
  },

  -- Setup DAP ``adapter``
  -- {
  --   "mason-nvim-dap.nvim",
  --   opts = {
  --     ensure_installed = { "`adapter`" },
  --   },
  -- },

  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end, -- avoid duplicate setup call because it also loads in line 102
    opts = {
      inlay_hints = {
        inline = false,
      },
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
  },
  -- Add `server` and setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
  },

  -- Setup null-ls with `clang_format`
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = vim.list_extend(opts.sources, {
  --       nls.builtins.formatting.clang_format.with({
  --         extra_args = {
  --           "-style=file:" .. vim.fn.expand("~/Desktop/Projects/C/.clang-format"),
  --         },
  --       }),
  --     })
  --   end,
  -- },
}
