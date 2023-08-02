local actions = require("telescope.actions")
local telescope_utils = require("telescope.actions.utils")

M = {}

M.mark_file = function(tb)
  actions.drop_all(tb)
  actions.add_selection(tb)
  telescope_utils.map_selections(tb, function(selection)
    -- TODO: This doesn't work for the git status picker, or the live grep picker. The formatting
    -- there is different, but consistent and detectable, so we should be fine there
    -- See: P(selection)
    local file = selection[1]
    pcall(require("harpoon.mark").add_file, file)
  end)
  actions.remove_selection(tb)
end

return M
