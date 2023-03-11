-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- local del = vim.keymap.del
local Util = require("lazyvim.util")

-- Visual-multi
map("n", "<C-Left>", "<Plug>(VM-Select-h)")
map("n", "<C-Right>", "<Plug>(VM-Select-l)")
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

-- Lazygit change size of window
map("n", "<leader>gg", function()
  Util.float_term({ "lazygit" }, { size = { width = 1.0, height = 1.0 }, cwd = Util.get_root() })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
  Util.float_term({ "lazygit" }, { size = { width = 1.0, height = 1.0 } })
end, { desc = "Lazygit (cwd dir)" })

-- Move to tabs convienently
map("n", "<leader>1", "1gt", { desc = "Move to tab 1" })
map("n", "<leader>2", "2gt", { desc = "Move to tab 2" })
map("n", "<leader>3", "3gt", { desc = "Move to tab 3" })
map("n", "<leader>4", "4gt", { desc = "Move to tab 4" })
map("n", "<leader>5", "5gt", { desc = "Move to tab 5" })
map("n", "<leader>6", "6gt", { desc = "Move to tab 6" })
map("n", "<leader>7", "7gt", { desc = "Move to tab 7" })
map("n", "<leader>8", "8gt", { desc = "Move to tab 8" })
map("n", "<leader>9", "9gt", { desc = "Move to tab 9" })

-- Open current file in chrome
map("n", "<leader>gx", '<cmd>!google-chrome "%"<cr>', { desc = "Open file in Chrome" })
