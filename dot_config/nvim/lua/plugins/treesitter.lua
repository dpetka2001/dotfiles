return {
  -- Modify Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- Add Playground
      {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        keys = {
          { "<leader>uth", "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Show highlight groups under the cursor" },
          { "<leader>utn", "<cmd>TSNodeUnderCursor<cr>", desc = "Show node under the cursor" },
        },
      },

      -- Add nvim-ts-autotag
      { "windwp/nvim-ts-autotag" },
    },
    -- event = { "BufReadPre" },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
        "fish",
        "rust",
      })
      return vim.tbl_deep_extend("force", opts, {
        autotag = {
          enable = true,
        },
      })
    end,
  },
}
