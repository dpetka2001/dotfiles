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

  -- Pomodoro timer
  {
    "dbinagi/nomodoro",
    dependencies = {
      {
        "folke/which-key.nvim",
        opts = {
          spec = {
            ["<leader>n"] = { name = "+nomodoro" },
          },
        },
      },
    },
    opts = {
      work_time = 25,
      break_time = 5,
      menu_available = true,
      texts = {
        on_break_complete = "BREAK IS UP!",
        on_work_complete = "TIME IS UP!",
        -- status_icon = "󰔟 ",
        timer_format = "!%0M:%0S", -- To include hours: '!%0H:%0M:%0S'
      },
    },
    keys = {
      { "<leader>nw", "<cmd>NomoWork<cr>", noremap = true, silent = true },
      { "<leader>nb", "<cmd>NomoBreak<cr>", noremap = true, silent = true },
      { "<leader>ns", "<cmd>NomoStop<cr>", noremap = true, silent = true },
    },
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
