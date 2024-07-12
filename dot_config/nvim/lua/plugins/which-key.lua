return {
  -- Modify which-key keys
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>un", group = "Notifications" },
        { "zd", "Delete fold under cursor" },
        { "zD", "Delete folds recursively under cursor" },
        { "zE", "Eliminate all folds in window" },
        { "]c", "Jump to next diff change" },
        { "[c", "Jump to previous diff change" },
        { "<leader>cl", group = "LSP" },
        { "<leader>T", group = "Terminal" },
        { "<leader>z", group = "Zoom" },
      },
    },
  },
}
