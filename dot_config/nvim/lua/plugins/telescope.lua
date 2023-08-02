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
      -- {
      --   "nvim-telescope/telescope-fzf-native.nvim",
      --   build = "make",
      -- },
      { "natecraddock/telescope-zf-native.nvim" },
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
            ["<c-a-t>"] = actions.select_tab,
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<Tab>"] = require("dpetka2001.harpoon").mark_file,
          },
          n = {
            ["<C-b>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
            -- Add opening multi-selection support to telescope pickers
            ["<CR>"] = multi_open,
            ["<Tab>"] = require("dpetka2001.harpoon").mark_file,
          },
        },
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            preview_width = 0.45,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
            preview_cutoff = 0,
          },
          flex = {
            flip_columns = 140,
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
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>xd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>xD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>xs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
      { "<leader>xS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },
      { "<leader>sM", "<cmd>Telescope man_pages sections=ALL<cr>", desc = "Man Pages" },
      { "<leader>ff", Util.telescope("find_files"), desc = "Find files (root dir not git)" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current Buffer Fuzzy" },
      { "<leader>gb", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer commits" },
    },
    -- Setup here extensions that depend on `telescope.opts`, otherwise just setup when it is called
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("project")
      telescope.load_extension("zf-native")
      -- telescope.load_extension("fzf")
    end,
  },

  -- Modify `alpha.nvim` to include `telescope-project`
  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      local button = dashboard.button("p", " " .. " Projects", ":Telescope project <CR>")
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      table.insert(dashboard.section.buttons.val, 4, button)
    end,
  },
}
