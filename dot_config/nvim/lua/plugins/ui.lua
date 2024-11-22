return {
  -- Modify `bufferline`
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bb", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    },
    -- opts = {
    --   options = {
    --     always_show_bufferline = true,
    --   },
    -- },
  },

  -- Modify `lualine`
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
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
