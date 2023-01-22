return {
  -- disable neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },

  -- use nvim-tree instead
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    version = "nightly",
    cmd = "NvimTreeToggle",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Nvim-tree" },
      {
        "<leader>E",
        "<cmd>lua require('nvim-tree.api').tree.change_root_to_node()<cr>",
        desc = "Nvim-tree change root to node",
      },
    },
    opts = {
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = false, -- Turn into false from true by default
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = { "help" },
      },
      view = {
        centralize_selection = true,
      },
    },
  },

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
          })
        end,
        desc = "Open Notifications (Telescope)",
      },
    },
  },
}
