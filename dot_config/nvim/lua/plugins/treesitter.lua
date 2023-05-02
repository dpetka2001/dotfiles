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

      -- Modify nvim-ts-context-commentstring
      { "JoosepAlviste/nvim-ts-context-commentstring" },
    },
    -- event = { "BufReadPre" },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "fish",
        "rust",
      })
      return vim.tbl_deep_extend("force", opts, {
        autotag = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          config = {
            c = { __default = "// %s", __multiline = "/* %s */" },
            cpp = { __default = "// %s", __multiline = "/* %s */" },
          },
        },
      })
    end,
  },
}
