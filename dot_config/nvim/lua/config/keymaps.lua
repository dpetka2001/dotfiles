-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- local del = vim.keymap.del

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                           Visual-multi                            │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<C-Left>", "<Plug>(VM-Select-h)")
map("n", "<C-Right>", "<Plug>(VM-Select-l)")
map("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)")
map("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)")

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                        Change window size                         │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │    More comfortable keys for searching history in command line    │
--     ╰───────────────────────────────────────────────────────────────────╯
map("c", "<C-j>", "<Down>", { desc = "Next command" })
map("c", "<C-k>", "<Up>", { desc = "Previous command" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Lazygit change size and options                  │
--     ╰───────────────────────────────────────────────────────────────────╯
-- WARN:
-- ╭────────────────────────────────────────────────────────────────────────────╮
-- │ Don't use `esc_esc = false` to not conflict with Lazygit <Esc> and be able │
-- │ to escape terminal mode and change tabs                                    │
-- ╰────────────────────────────────────────────────────────────────────────────╯
map("n", "<leader>gg", function()
  LazyVim.lazygit({ size = { width = 1.0, height = 1.0 }, esc_esc = true, cwd = LazyVim.root.get() })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
  LazyVim.lazygit({ size = { width = 1.0, height = 1.0 }, esc_esc = true })
end, { desc = "Lazygit (cwd dir)" })
map("n", "<leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  LazyVim.lazygit({ args = { "-f", vim.trim(git_path) }, size = { width = 1.0, height = 1.0 }, esc_esc = true })
end, { desc = "Lazygit current file history" })
-- INFO:
-- ╭───────────────────────────────────────────────────────────────────╮
-- │ Using `[[]]` instead of single/double quotes allows to not        │
-- │ escape special characters                                         │
-- ╰───────────────────────────────────────────────────────────────────╯
map("t", "<Esc><Esc>", [[<C-\><C-n>0]])

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                     Move to tabs convienently                     │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>1", "1gt", { desc = "Move to tab 1" })
map("n", "<leader>2", "2gt", { desc = "Move to tab 2" })
map("n", "<leader>3", "3gt", { desc = "Move to tab 3" })
map("n", "<leader>4", "4gt", { desc = "Move to tab 4" })
map("n", "<leader>5", "5gt", { desc = "Move to tab 5" })
map("n", "<leader>6", "6gt", { desc = "Move to tab 6" })
map("n", "<leader>7", "7gt", { desc = "Move to tab 7" })
map("n", "<leader>8", "8gt", { desc = "Move to tab 8" })
map("n", "<leader>9", "9gt", { desc = "Move to tab 9" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                 Close buffer and window together                  │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>bw", "<cmd>execute 'bdelete' | silent! close<cr>", { desc = "Close buffer and window" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                    Open current file in chrome                    │
--     ╰───────────────────────────────────────────────────────────────────╯
-- map("n", "<leader>fx", '<cmd>!google-chrome "%"<cr>', { desc = "Open file in Chrome" })
-- stylua: ignore
map("n", "<leader>fx", '<cmd>silent !/home/jrn23/.local/opt/firefox/firefox "%"<cr>', { silent = true, desc = "Open file in Firefox Developer" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                        vim-tmux-navigator                         │
--     ╰───────────────────────────────────────────────────────────────────╯
if os.getenv("TMUX") then
  map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
  map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
  map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
  map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
end

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                           Open scratch                            │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>S", function()
  require("dpetka2001.scratch").launch_notepad()
end, { silent = true, desc = "Open Scratch" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │          Testing key overloading for speeding up macros           │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "@", function()
  local count = vim.v.count1
  local register = vim.fn.getcharstr()
  vim.opt.lazyredraw = true
  vim.api.nvim_command(string.format("noa norm! %d@%s", count, register))
  vim.opt.lazyredraw = false
  -- vim.api.nvim_command("silent update")
end, { noremap = true })

map(
  "x",
  "@",
  [[:<C-u>set lazyredraw <bar> execute "noautocmd '<,'>norm! " . v:count1 . "@" . getcharstr() <bar> set nolazyredraw<cr>]],
  { noremap = true, silent = true }
)

map(
  "x",
  "Q",
  [[:<C-u>set lazyredraw <bar> execute "noautocmd '<,'>norm! Q" <bar> set nolazyredraw<cr>]],
  { noremap = true, silent = true }
)

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                         Harpoon mappings                          │
--     ╰───────────────────────────────────────────────────────────────────╯
-- stylua: ignore
if vim.bo["filetype"] ~= "rnvimr" then
  map("n", "<M-1>", function() require("harpoon.ui").nav_file(1) end, { desc = "Harpoon 1" })
  map("n", "<M-2>", function() require("harpoon.ui").nav_file(2) end, { desc = "Harpoon 2" })
  map("n", "<M-3>", function() require("harpoon.ui").nav_file(3) end, { desc = "Harpoon 3" })
  map("n", "<M-4>", function() require("harpoon.ui").nav_file(4) end, { desc = "Harpoon 4" })
  map("n", "<M-5>", function() require("harpoon.ui").nav_file(5) end, { desc = "Harpoon 5" })
  map("n", "<M-6>", function() require("harpoon.ui").nav_file(6) end, { desc = "Harpoon 6" })
  map("n", "<M-7>", function() require("harpoon.ui").nav_file(7) end, { desc = "Harpoon 7" })
  map("n", "<M-8>", function() require("harpoon.ui").nav_file(8) end, { desc = "Harpoon 8" })
  map("n", "<M-9>", function() require("harpoon.ui").nav_file(9) end, { desc = "Harpoon 9" })
  map("n", "<M-0>", function() require("harpoon.ui").nav_file(0) end, { desc = "Harpoon 0" })
end

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                    Visual Selection Formatting                    │
--     ╰───────────────────────────────────────────────────────────────────╯
map("v", "<leader>ct", "<cmd>lua vim.lsp.buf.format({async=true})<cr>", { desc = "Visual Formatting" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                 Word/Line Completion with Codeium                 │
--     ╰───────────────────────────────────────────────────────────────────╯
-- See https://github.com/Exafunction/codeium.vim/issues/27#issuecomment-1948401179 for info
local expr_opts = {
  noremap = true,
  silent = true,
  expr = true,
  -- With expr = true, replace_keycodes is set to true. See https://github.com/orgs/community/discussions/29817
  -- We need to set it to false to avoid extraneous caracters when accepting a suggestion.
  replace_keycodes = false,
}

local function getCodeiumCompletions()
  local status, completion = pcall(function()
    return vim.api.nvim_eval("b:_codeium_completions.items[b:_codeium_completions.index].completionParts[0].text")
  end)
  if status then
    return completion
  else
    return ""
  end
end
local function accept_one_line()
  local text = getCodeiumCompletions()
  return vim.fn.split(text, [[[\n]\zs]])[1] .. "\n"
end
local function accept_one_word()
  local text = getCodeiumCompletions()
  return vim.fn.split(text, [[\(\w\+\|\W\+\)\zs]])[1]
end

vim.keymap.set("i", "<C-j>", accept_one_line, expr_opts)
vim.keymap.set("i", "<C-l>", accept_one_word, expr_opts)
