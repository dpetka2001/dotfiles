return {
  -- Add pyright to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "pyright", "black" })
    end,
  },

  -- Setup null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return nls.register({ nls.builtins.formatting.black })
    end,
  },
}
