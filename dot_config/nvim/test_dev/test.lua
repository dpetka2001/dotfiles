local added = {}
print(vim.inspect(vim.tbl_filter(function(lang)
  if added[lang] then
    return false
  end
  added[lang] = true
  return true
end, { "rust", "cpp", "ada", "rust", "ada", "c", "bash" })))
