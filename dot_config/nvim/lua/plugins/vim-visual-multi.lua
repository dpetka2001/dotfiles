return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.VM_mouse_mappings = 1
      vim.g.VM_theme = "purplegray"
    end,
  },
}
