return {
  -- Modify which-key keys
  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        ["<leader>xl"] = {
          name = "+LSP (Telescope)",
        },
        ["<leader>un"] = {
          name = "+Notifications",
        },
      })
    end,
  },
}
