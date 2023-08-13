-- See github issue (https://github.com/folke/noice.nvim/issues/163#issuecomment-1427022139)
local util = require("vim.lsp.util")

local function make_position_param(window, offset_encoding)
  window = window or 0
  local buf = vim.api.nvim_win_get_buf(window)
  local row, col

  local mouse = vim.fn.getmousepos()
  row = mouse.line
  col = mouse.column

  offset_encoding = offset_encoding or util._get_offset_encoding(buf)
  row = row - 1
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, true)[1]
  if not line then
    return { line = 0, character = 0 }
  end
  if #line < col then
    return { line = 0, character = 0 }
  end

  col = util._str_utfindex_enc(line, col, offset_encoding)

  return { line = row, character = col }
end

local make_params = function(window, offset_encoding)
  window = window or 0
  local buf = vim.api.nvim_win_get_buf(window)
  offset_encoding = offset_encoding or util._get_offset_encoding(buf)
  return {
    textDocument = util.make_text_document_params(buf),
    position = make_position_param(window, offset_encoding),
  }
end

local hover_timer = nil
vim.o.mousemoveevent = true

vim.keymap.set({ "", "i" }, "<MouseMove>", function()
  if hover_timer then
    hover_timer:close()
  end
  hover_timer = vim.defer_fn(function()
    hover_timer = nil
    local params = make_params()
    vim.lsp.buf_request(
      0,
      "textDocument/hover",
      params,
      vim.lsp.with(vim.lsp.handlers.hover, {
        silent = true,
        focusable = false,
        relative = "mouse",
      })
    )
  end, 500)
  return "<MouseMove>"
end, { expr = true })
