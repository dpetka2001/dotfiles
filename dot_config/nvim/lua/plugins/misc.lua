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

  -- Distinguish windows with colorful borders
  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      create_event = function()
        local colorful_winsep = require("colorful-winsep")
        local filetypes = { "neo-tree", "Trouble" }
        local win_n = require("colorful-winsep.utils").calculate_number_windows()
        if win_n == 2 then
          local win_id
          local cur_win_id = vim.fn.win_getid(vim.fn.winnr())
          if vim.fn.win_getid(vim.fn.winnr("h")) == cur_win_id then
            win_id = vim.fn.win_getid(vim.fn.winnr("j"))
          else
            win_id = vim.fn.win_getid(vim.fn.winnr("h"))
          end
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(win_id) })
          if vim.tbl_contains(filetypes, filetype) then
            colorful_winsep.NvimSeparatorDel()
          end
        end
      end,
    },
  },

  -- Dim inactive windows
  {
    "levouh/tint.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      saturation = 0.4,
    },
    keys = {
      { "<leader>uT", "<cmd>lua require('tint').toggle()<cr>", desc = "Toggle tint" },
    },
  },

  -- Disable certain features if file is big
  {
    "LunarVim/bigfile.nvim",
    opts = {},
  },
}
