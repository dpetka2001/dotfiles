return {
  {
    "folke/flash.nvim",
    keys = {
      {
        "]f",
        function()
          require("flash").jump({
            action = function(match, state)
              vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                vim.diagnostic.open_float()
                vim.api.nvim_win_set_cursor(match.win, state.pos)
              end)
            end,
          })
        end,
        desc = "Flash diagnostic at chosen target",
      },
      {
        "]F",
        "<cmd>lua require('flash.plugins.diagnostics').show()<cr>",
        desc = "Flash All Diagnostics",
      },
    },
  },
}
