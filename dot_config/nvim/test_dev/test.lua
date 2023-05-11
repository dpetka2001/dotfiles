---@type table<string, boolean>
local added = {}
-- stylua: ignore start
local ensure_installed = {
  "rust", "cpp", "ada", "rust", "c", "ada", "bash"
}
-- stylua: ignore end

print(vim.inspect(vim.tbl_filter(function(lang)
  if added[lang] then
    return false
  end
  added[lang] = true
  return true
end, ensure_installed)))
