return {
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

  -- Maximizer
  {
    "declancm/maximize.nvim",
    keys = {
      { "<Leader>z", "<Cmd>lua require('maximize').toggle()<CR>", desc = "Toggle maximize" },
    },
  },
}
