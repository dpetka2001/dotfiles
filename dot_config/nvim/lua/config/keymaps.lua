-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<S-h>", "<Plug>(VM-Select-h)")
vim.keymap.set("n", "<S-l>", "<Plug>(VM-Select-l)")
vim.keymap.set("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)")
vim.keymap.set("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)")
vim.keymap.set("n", "<A-t>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-s>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
