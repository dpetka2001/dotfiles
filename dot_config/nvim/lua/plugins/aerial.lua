return {
  {
    "stevearc/aerial.nvim",
    opts = function(_, opts)
      opts.filter_kind = false
      opts.layout.max_width = { 40, 0.5 }
      opts.layout.min_width = 35
    end,
    keys = {
      { "<leader>cn", "<cmd>AerialNavToggle<cr>", desc = "Aerial (Nav)" },
    },
  },
}
