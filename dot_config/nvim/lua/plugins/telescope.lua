local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local Util = require("lazyvim.util")

local multi_open = function(pb)
  local picker = action_state.get_current_picker(pb)
  local multi = picker:get_multi_selection()
  actions.select_default(pb) -- the normal enter behaviour
  for _, j in pairs(multi) do
    if j.path ~= nil then -- is it a file -> open it as well:
      vim.cmd(string.format("%s %s", "edit", j.path))
    end
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-project.nvim",
        keys = {
          { "<C-p>", "<cmd>lua require'telescope'.extensions.project.project{}<cr>", desc = "Telescope Project" },
        },
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-b>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
            -- Add opening multi-selection support to telescope pickers
            ["<CR>"] = multi_open,
          },
          n = {
            ["<C-b>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
            -- Add opening multi-selection support to telescope pickers
            ["<CR>"] = multi_open,
          },
        },
        layout_config = {
          horizontal = {
            preview_width = 0.45,
          },
          flex = {
            preview_width = 0.45,
          },
        },
      },
      pickers = {
        buffers = {
          initial_mode = "normal",
        },
      },
      extensions = {
        project = {
          base_dirs = {
            { path = "~/Desktop/Projects/" },
            { path = "~/projects/plugins/" },
            { path = "~/.local/share/chezmoi/" },
            { path = "~/.local/share/nvim/" },
          },
        },
      },
    },
    keys = {
      { "<leader>xS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },
      { "<leader>xs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
      { "<leader>sM", "<cmd>Telescope man_pages sections=ALL<cr>", desc = "Man Pages" },
      { "<leader>ff", Util.telescope("find_files"), desc = "Find files (root dir not git)" },
    },
    -- Setup here extensions that depend on `telescope.opts`, otherwise just setup when it is called
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("project")
      telescope.load_extension("fzf")
    end,
  },
}
