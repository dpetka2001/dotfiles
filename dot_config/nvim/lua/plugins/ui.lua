return {
  -- Modify nvim-notify for Telescope
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>und",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
      {
        "<leader>unt",
        function()
          require("telescope").extensions.notify.notify({
            initial_mode = "normal",
            -- layout_strategy = "vertical",
          })
        end,
        desc = "Open Notifications (Telescope)",
      },
    },
  },

  -- Modify `bufferline`
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
}
