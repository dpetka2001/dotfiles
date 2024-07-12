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
          if LazyVim.has("telescope.nvim") then
            require("telescope").extensions.notify.notify({
              initial_mode = "normal",
              -- layout_strategy = "vertical",
            })
          else
            LazyVim.on_load("which-key.nvim", function()
              require("which-key").add({
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
    keys = {
      { "<leader>bb", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    },
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },

  -- Modify `lualine`
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local timer = function()
        return require("nomodoro").status()
      end

      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        max_items = 5,
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
      })

      -- ╭───────────────────────────────────────────────────────────────────╮
      -- │                             lualine_c                             │
      -- ╰───────────────────────────────────────────────────────────────────╯
      opts.sections.lualine_c[#opts.sections.lualine_c] = {
        symbols.get,
        cond = symbols.has,
      }

      -- ╭───────────────────────────────────────────────────────────────────╮
      -- │                             lualine_x                             │
      -- ╰───────────────────────────────────────────────────────────────────╯
      table.insert(opts.sections.lualine_x, { "encoding" })
      table.insert(opts.sections.lualine_x, { timer })

      -- ╭───────────────────────────────────────────────────────────────────╮
      -- │                             lualine_z                             │
      -- ╰───────────────────────────────────────────────────────────────────╯
      opts.sections.lualine_z = {}
    end,
  },

  {
    "trouble.nvim",
    opts = {
      preview = { type = "float", border = "rounded" },
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = {
          silent = true,
        },
        signature = {
          opts = {
            size = {
              max_height = 15,
            },
          },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
