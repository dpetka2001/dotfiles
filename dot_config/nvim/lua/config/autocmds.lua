-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local util = require("lazyvim.util")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

--[[ -------------
     AUTO COMMANDS
     ------------- ]]

-- Prefer creating groups and assigning autocmds to groups, because it makes it easier to clear them
--[[ Mygroup Group ]]
augroup("mygroup", { clear = true })

-- Disable `lazyvim_resize_splits` as it conflicts with tmux window resizing
augroup("lazyvim_resize_splits", { clear = true })

autocmd("Filetype", {
  pattern = { "*" },
  callback = function()
    -- vim.opt.formatoptions = vim.opt.formatoptions - "o"
    vim.opt.formatoptions = vim.opt.formatoptions + {
      o = false, -- Don't continue comments with o and O
    }
  end,
  group = "mygroup",
  desc = "Don't continue comments with o and O",
})

-- Disable Ufo for neo-tree
autocmd("Filetype", {
  pattern = "neo-tree",
  callback = function()
    if package.loaded["ufo"] then
      vim.cmd("UfoDetach")
    end
  end,
  group = "mygroup",
  desc = "Disable Ufo for neo-tree",
})

-- Reload config on save
autocmd("BufWritePost", {
  -- Match all `lua` files in `lua/config` except `lazy.lua` which is the
  -- setup file for `lazy.nvim` and should only be reloaded when updated.
  pattern = "**/lua/config/*[^lazy].lua",
  callback = function()
    local filepath = vim.fn.expand("%")
    dofile(filepath)
    vim.notify("Configuration reloaded \n" .. filepath, nil)
  end,
  group = "mygroup",
  desc = "Reload config on save",
})

-- ToggleTerm
function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    set_terminal_keymaps()
  end,
  group = "mygroup",
  desc = "Set terminal mappings for ToggleTerm",
})

-- I don't believe this is necessary any more, since installed `LunarVim/bigfile.nvim`
-- Disable tree-sitter for files over 1MB in size
-- autocmd("BufRead", {
--   pattern = "*",
--   callback = function()
--     local size = vim.fn.getfsize(vim.fn.expand("%:p"))
--     if size > 500000 then
--       vim.treesitter.stop()
--     end
--   end,
--   group = "mygroup",
--   desc = "Disable Treesitter for files larger than 1MB",
-- })

--[[ Remember Folds Group ]]
augroup("remember_folds", { clear = true })

autocmd({ "BufLeave", "BufWinLeave" }, {
  pattern = "*",
  callback = function()
    vim.cmd("silent! mkview")
  end,
  group = "remember_folds",
  desc = "Remember folds on buffer exit",
})

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! loadview")
  end,
  group = "remember_folds",
  desc = "Restore folds on buffer enter",
})

--[[ -------------
     USER COMMANDS
     ------------- ]]

usercmd("Rwd", function()
  print(util.get_root())
end, { desc = "Print root_dir of current buffer" })

-- User command for diffing current buffer when not in .git repo
usercmd("DiffOrig", function()
  local scratch_buffer = vim.api.nvim_create_buf(false, true)
  local current_ft = vim.bo.filetype
  vim.cmd("vertical sbuffer" .. scratch_buffer)
  vim.bo[scratch_buffer].filetype = current_ft
  vim.cmd("read ++edit #") -- load contents of previous buffer into scratch_buffer
  vim.cmd.normal('1G"_d_') -- delete extra newline at top of scratch_buffer without overriding register
  vim.cmd.diffthis() -- scratch_buffer
  vim.cmd.wincmd("p")
  vim.cmd.diffthis() -- current buffer
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = scratch_buffer, silent = true })
end, { desc = "Print root_dir of current buffer" })
