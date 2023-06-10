return {
  -- Better matching text/pairs, based on treesitter language-specific words rather than
  -- just single characters
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    init = function()
      vim.o.matchpairs = "(:),{:},[:],<:>"
    end,
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  -- Dims inactive portions of the code you're editing
  {
    "folke/twilight.nvim",
    lazy = true,
  },

  -- Opens the current buffer in a new full-screen floating window
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
