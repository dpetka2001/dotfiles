return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    -- event = { "BufReadPost", "BufNewFile" },
    event = "LazyFile",
    init = function()
      vim.g.VM_theme = "purplegray"
      vim.g.VM_mouse_mappings = 1
    end,
  },
}
