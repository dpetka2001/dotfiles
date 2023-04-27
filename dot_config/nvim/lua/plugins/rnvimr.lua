return {
  {
    "kevinhwang91/rnvimr",
    lazy = true,
    cmd = { "RnvimrToggle" },
    keys = {
      { "<M-o>", "<cmd>RnvimrToggle<CR>", desc = "Rnvimr Toggle" },
      { "<M-o>", "<C-\\><C-n><cmd>RnvimrToggle<CR>", mode = { "t" }, desc = "Rnvimr Toggle" },
    },
  },
}
