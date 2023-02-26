-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local util = require("lazyvim.util")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

--[[ Auto Commands ]]

-- Prefer creating groups and assigning autocmds to groups, because it makes it easier to clear them
augroup("mygroup", { clear = true })

autocmd("Filetype", {
  pattern = { "*" },
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" -- Don't continue comments with o and O
  end,
  group = "mygroup",
  desc = "Don't continue comments with o and O",
})

autocmd("Filetype", {
  pattern = { "*" },
  callback = function()
    local comment_ft = require("Comment.ft")
    comment_ft.set("lua", { "--%s", "--[[%s]]" })
  end,
  group = "mygroup",
  desc = "Set line/block type comments for Lua",
})

autocmd("BufWritePost", {
  -- Match all `lua` files in `lua/config` except `lazy.lua` which is the
  -- setup file for `lazy.nvim` and doesn't support reloading
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
  pattern = "term://*",
  callback = function()
    set_terminal_keymaps()
  end,
  group = "mygroup",
  desc = "Set terminal mappings for ToggleTerm",
})

-- Colorscheme
autocmd("Colorscheme", {
  pattern = "*",
  callback = function()
    vim.cmd([[
      hi link NavicText lualine_c_normal
      hi link NavicIconsFile lualine_c_normal
      hi link NavicIconsModule lualine_c_normal
      hi link NavicIconsNamespace lualine_c_normal
      hi link NavicIconsPackage lualine_c_normal
      hi link NavicIconsClass lualine_c_normal
      hi link NavicIconsMethod lualine_c_normal
      hi link NavicIconsProperty lualine_c_normal
      hi link NavicIconsField lualine_c_normal
      hi link NavicIconsConstructor lualine_c_normal
      hi link NavicIconsEnum lualine_c_normal
      hi link NavicIconsInterface lualine_c_normal
      hi link NavicIconsFunction lualine_c_normal
      hi link NavicIconsVariable lualine_c_normal
      hi link NavicIconsConstant lualine_c_normal
      hi link NavicIconsString lualine_c_normal
      hi link NavicIconsNumber lualine_c_normal
      hi link NavicIconsBoolean lualine_c_normal
      hi link NavicIconsArray lualine_c_normal
      hi link NavicIconsObject lualine_c_normal
      hi link NavicIconsKey lualine_c_normal
      hi link NavicIconsNull lualine_c_normal
      hi link NavicIconsEnumMember lualine_c_normal
      hi link NavicIconsStruct lualine_c_normal
      hi link NavicIconsEvent lualine_c_normal
      hi link NavicIconsOperator lualine_c_normal
      hi link NavicIconsTypeParameter lualine_c_normal
      hi link NavicText lualine_c_normal
      hi link NavicSeparator lualine_c_normal
    ]])
  end,
  group = "mygroup",
  desc = "Set highlight groups for navic",
})

--[[ User Commands ]]

usercmd("Rwd", function()
  print(util.get_root())
end, { desc = "Print root_dir of current buffer" })
