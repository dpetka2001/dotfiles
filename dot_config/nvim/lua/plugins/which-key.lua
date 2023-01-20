return {

  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        ["<leader>x"] = {
          name = "+diagnostics/quickfix",
          l = { name = "+LSP (Telescope)" },
        },
      })
    end,
  },
}
