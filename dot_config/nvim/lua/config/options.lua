-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Indent
opt.autoindent = true -- Copy indent from current line when starting a new line (When <CR> or 'o' or 'O')
opt.smarttab = true -- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'

-- Set this for ToggleTerm terminals to not be discarded when closed
opt.hidden = true

-- Set fold level, so that folds are open when entering buffer
-- opt.foldcolumn = "1"
-- opt.foldlevel = 99
-- opt.foldlevelstart = 99
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Set eventignore so that tmux does not show `activity` every time we change from a window with Neovim
opt.eventignore = "FocusLost"

opt.viewoptions = "folds"
