return {
  -- Modify nvim-dap
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { '<leader>dj', function() require('dap').down() end, desc = 'Down in current stacktrace' },
      { '<leader>dk', function() require('dap').up() end, desc = 'Up in current stacktrace' },
      { '<F5>', function() require('dap').continue() end, desc = 'Continue' },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    },
  },

  {
    "jbyuki/one-small-step-for-vimkind",
    keys = {
    -- stylua: ignore
      { "<leader>dL", function() require("osv").launch { port = 8086 } end, desc = "Launch Lua adapter" },
    },
  },
}
