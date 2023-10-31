local icons = require("lazyvim.config").icons
local Util = require("lazyvim.util")

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
          if Util.has("telescope.nvim") then
            require("telescope").extensions.notify.notify({
              initial_mode = "normal",
              -- layout_strategy = "vertical",
            })
          else
            Util.on_load("which-key.nvim", function()
              require("which-key").register({
                ["<leader>unt"] = "which_key_ignore",
              })
              vim.keymap.del("n", "<leader>unt")
            end)
          end
        end,
        desc = "Open Notifications (Telescope)",
      },
    },
  },

  -- Modify `bufferline`
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    -- event = function()
    --   return { "BufReadPost", "BufNewFile" }
    -- end,
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
          Util.lualine.root_dir(),
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
          { Util.lualine.pretty_path() },
          -- { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
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
        return require("nomodoro").status()
      end
      table.insert(opts.sections.lualine_x, { "encoding" })
      table.insert(opts.sections.lualine_x, { timer })
    end,
  },

  -- Lualine for aerial
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        "aerial",
        sep = " ", -- separator between symbols
        sep_icon = "", -- separator between icon and symbol

        -- The number of symbols to render top-down. In order to render only 'N' last
        -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
        -- be used in order to render only current symbol.
        depth = 5,

        -- When 'dense' mode is on, icons are not rendered near their symbols. Only
        -- a single icon that represents the kind of current symbol is rendered at
        -- the beginning of status line.
        dense = false,

        -- The separator to be used to separate symbols in dense mode.
        dense_sep = ".",

        -- Color the symbol icons.
        colored = true,
      })
    end,
  },

  -- Style windows with different colorschemes
  -- {
  --   "folke/styler.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = {
  --     themes = {
  --       markdown = { colorscheme = "catppuccin" },
  --       help = { colorscheme = "catppuccin", background = "dark" },
  --     },
  --   },
  -- },

  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
