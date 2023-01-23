-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Prefer creating groups and assigning autocmds to groups, because it makes it easier to clear them
vim.api.nvim_create_augroup("MyCustomFormatOptions", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "*" },
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" -- Don't continue comments with o and O
  end,
  group = "MyCustomFormatOptions",
})
