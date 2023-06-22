local function diag_jump()
  require("flash").jump({
    -- adds highlight to diagnostics targets
    matcher = function(win)
      ---@param diag Diagnostic
      return vim.tbl_map(function(diag)
        return {
          pos = { diag.lnum + 1, diag.col },
          end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
        }
      end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
    end,
    action = function(match, state)
      vim.api.nvim_win_call(match.win, function()
        vim.api.nvim_win_set_cursor(match.win, match.pos)
        vim.diagnostic.open_float()
        vim.api.nvim_win_set_cursor(match.win, state.pos)
      end)
    end,
  })
end

return {
  {
    "folke/flash.nvim",
    keys = {
      {
        "]f",
        diag_jump,
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
