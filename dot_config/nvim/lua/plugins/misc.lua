return {
  -- Better matching text/pairs, based on treesitter language-specific words rather than
  -- just single characters
  {
    "andymass/vim-matchup",
    -- WARN:
    --  ╭──────────────────────────────────────────────────────────────────────╮
    --  │ Don't use `LazyFile`, because it doesn't work with `nvim-treesitter` │
    --  ╰──────────────────────────────────────────────────────────────────────╯

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
    cmd = "Twilight",
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

  -- vim-tmux-navigator
  {
    "christoomey/vim-tmux-navigator",
  },

  -- Better join/split
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  -- Structural Search and Replace
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sp",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
}
