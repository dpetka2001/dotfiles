return {
  -- Add `pyright` to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- vim.list_extend(opts.ensure_installed, { "pyright", "black", "ruff-lsp", "ruff" })
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "black",
        "ruff-lsp",
        "ruff",
      })
    end,
  },

  -- Setup null-ls with `black`
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.black,
        nls.builtins.formatting.ruff,
        -- nls.builtins.diagnostics.ruff,
      })
    end,
  },
}
