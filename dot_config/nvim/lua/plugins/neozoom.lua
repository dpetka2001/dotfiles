return {
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
