return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-b>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
          },
          n = {
            ["<C-b>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
          },
        },
        layout_config = {
          preview_width = 0.5,
        },
      },
      pickers = {
        buffers = {
          initial_mode = "normal",
        },
      },
    },
    keys = {
      { "<leader>xlw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },
      { "<leader>xls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
      { "<leader>xld", "<cmd>Telescope diagnostics<cr>", desc = "LSP Diagnostics" },
    },
  },
}
