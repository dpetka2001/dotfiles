return {
  -- Manipulate windows height and width with animations
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim" },
    },
    opts = {
      autowidth = {
        enable = true,
        windidth = 10,
        winminwidth = 10,
        equalalways = false,
      },
    },
    keys = {
      { "<C-w>z", "<cmd>WindowsMaximize<cr>", desc = "WindowsMaximize" },
      { "<C-w>_", "<cmd>WindowsMaximizeVertically<cr>", desc = "WindowsMaximizeVertically" },
      { "<C-w>|", "<cmd>WindowsMaximizeHorizontally<cr>", desc = "WindowsMaximizeHorizontally" },
      { "<C-w>=", "<cmd>WindowsEqualize<cr>", desc = "WindowsEqualize" },
    },
  },

  -- Toggle maximize for current window and restore
  {
    "declancm/maximize.nvim",
    keys = {
      { "<Leader>zm", "<Cmd>lua require('maximize').toggle()<CR>", desc = "Toggle maximize" },
    },
  },
}
