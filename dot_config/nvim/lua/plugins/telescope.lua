local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

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
            -- Add opening multi-selection support to telescope pickers
            ["<CR>"] = function(pb)
              local picker = action_state.get_current_picker(pb)
              local multi = picker:get_multi_selection()
              actions.select_default(pb) -- the normal enter behaviour
              for _, j in pairs(multi) do
                if j.path ~= nil then -- is it a file -> open it as well:
                  vim.cmd(string.format("%s %s", "edit", j.path))
                end
              end
            end,
          },
          n = {
            -- Add opening multi-selection support to telescope pickers
            ["<C-b>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
            ["<CR>"] = function(pb)
              local picker = action_state.get_current_picker(pb)
              local multi = picker:get_multi_selection()
              actions.select_default(pb) -- the normal enter behaviour
              for _, j in pairs(multi) do
                if j.path ~= nil then -- is it a file -> open it as well:
                  vim.cmd(string.format("%s %s", "edit", j.path))
                end
              end
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
