augroup LuaHighlight
  au!
  au TextYankPost * lua vim.highlight.on_yank {
        \ higroup = "Substitute",
        \ timeout = 500,
        \ on_macro = true
        \ }
augroup END
