return {
  -- Modify which-key keys
  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        -- ["<leader>xl"] = {
        --   name = "+LSP (Telescope)",
        -- },
        ["<leader>un"] = {
          name = "+Notifications",
        },
        ["<leader>gh"] = { name = "+hunks", ["🚫"] = "which_key_ignore" },
        ["zd"] = { "Delete fold under cursor" },
        ["zD"] = { "Delete folds recursively under cursor" },
        ["zE"] = { "Eliminate all folds in window" },
        ["]c"] = { "Jump to next diff change" },
        ["[c"] = { "Jump to previous diff change" },
        ["<leader>T"] = {
          name = "+Terminal",
        },
        ["<leader>z"] = {
          name = "+Zoom",
        },
      })
    end,
  },
}
