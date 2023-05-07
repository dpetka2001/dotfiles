local M = {}

-- Insert values into a list if they don't already exist
---@param tbl string[]
---@param vals string|string[]
function M.list_insert_unique(tbl, vals)
  if type(vals) ~= "table" then
    vals = { vals }
  end
  for _, val in ipairs(vals) do
    if not vim.tbl_contains(tbl, val) then
      table.insert(tbl, val)
    end
  end
end

return M
