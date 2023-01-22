return {
  -- Add `lang` to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "`lang`"})
    end,
  },

  -- Add `server` to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "`server`"})
    end,
  },

  -- Setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      setup = {
        `server` = function(_, opts)
        end,
      },
    },
  },
}
