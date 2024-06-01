return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = function(_, opts)
      opts.library = {
        vim.env.LAZY .. "/luvit-meta/library", -- see below
        -- vim.env.LAZY .. "/LazyVim",
        Plugins["LazyVim"].dir,
      }
    end,
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
