local icons = require("lazyvim.config").icons

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
    event = function()
      return { "BufReadPost", "BufNewFile" }
    end,
    opts = {
      options = {
        always_show_bufferline = true,
        -- custom_filter = function(buf, _)
        --   -- get the current tab page number
        --   local current_tab = vim.api.nvim_get_current_tabpage()
        --   -- get a list of buffers for a specific tab
        --   local tab_buffers = vim.fn.tabpagebuflist(current_tab)
        --   -- check if the current buffer is being viewed in the current tab
        --   return vim.tbl_contains(tab_buffers, buf)
        -- end,
        -- custom_filter = function(buf_number)
        --   if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
        --     return true
        --   end
        -- end,
      },
    },
  },

  -- Modify `lualine`
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          -- stylua: ignore
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            -- For other colorschemes that have a weird space at the end
            padding = { left =1, right = 0 },
          },
        },
        lualine_z = {},
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local timer = function()
        return require("countdown").get_time()
      end
      table.insert(opts.sections.lualine_x, { "encoding" })
      table.insert(opts.sections.lualine_x, { timer })
    end,
  },
}
