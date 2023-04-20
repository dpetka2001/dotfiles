---@type UfoFoldVirtTextHandler
local foldVirtualTextHandler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
    },
    {
      "kevinhwang91/nvim-ufo",
      dependencies = "kevinhwang91/promise-async",
      event = "BufReadPost",
      ---@class UfoConfig
      opts = {
        fold_virt_text_handler = foldVirtualTextHandler,
      },
      keys = {
        {
          "zR",
          function()
            require("ufo").openAllFolds()
          end,
          desc = "Open all folds",
        },
        {
          "zM",
          function()
            require("ufo").closeAllFolds()
          end,
          desc = "Close all folds",
        },
        {
          "zr",
          function()
            require("ufo").openFoldsExceptKinds()
          end,
          desc = "Open more",
        },
        {
          "zm",
          function()
            require("ufo").closeFoldsWith()
          end,
          desc = "Close more",
        },
      },
    },
  },
}
