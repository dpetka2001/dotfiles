return {
  -- Install Treesitter Playground
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    keys = {
      { "<leader>uth", "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Show highlight groups under the cursor" },
      { "<leader>utn", "<cmd>TSNodeUnderCursor<cr>", desc = "Show node under the cursor" },
    },
  },

  -- Add parsers to Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
        "fish",
        "rust",
      })
    end,
  },
}
