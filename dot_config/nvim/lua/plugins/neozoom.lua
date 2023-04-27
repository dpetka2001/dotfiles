return {
  -- Try out NeoZoom, that allows you to toggle your current window into a
  -- floating one
  {
    "nyngwang/NeoZoom.lua",
    lazy = true,
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
      winopts = {
        offset = {
          -- Omit `top` and/or `left` to center the floating window
          width = 150,
          height = 0.85,
        },
      },
    },
  },
}
