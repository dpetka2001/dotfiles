-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Visual-multi
map("n", "<S-h>", "<Plug>(VM-Select-h)")
map("n", "<S-l>", "<Plug>(VM-Select-l)")
map("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)")
map("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)")

-- Change window size
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

-- More comfortable keys for searching history in command line
map("c", "<C-j>", "<Down>", { desc = "Next command" })
map("c", "<C-k>", "<Up>", { desc = "Previous command" })
