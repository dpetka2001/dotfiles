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

  -- Try out NeoZoom, that allows you to toggle your current window into a
  -- floating one
  {
    "nyngwang/NeoZoom.lua",
    keys = {
      {
        "<leader><CR>",
        function()
          vim.cmd("NeoZoomToggle")
        end,
        desc = "NeoZoom Toggle",
      },
    },
    opts = {
      scrolloff_on_enter = 7,
      exclude_buftypes = { "terminal" },
    },
  },
}
