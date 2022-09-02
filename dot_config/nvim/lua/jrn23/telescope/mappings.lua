local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('jrn23.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ff.", "edit_config")

-- Files
map_tele("<leader>rg", "multi_rg")
map_tele("<leader>fd", "fd")
-- map_tele("<leader>fs", "fs")
map_tele("<space>fz", "search_only_certain_files")
map_tele("<space>bo", "oldfiles")
-- map_tele("<space>fb", "file_browser")

-- Nvim
map_tele("<space>bl", "buffers")
map_tele("<space>ip", "installed_plugins")
map_tele("<space>ff", "search_all_files")
map_tele("<C-/>", "curbuf")
map_tele("<leader>h", "help_tags")
map_tele("<leader>vo", "vim_options")
map_tele("<leader>mp", "manpages")

-- LSP
map_tele("<leader>gw", "lsp_document_symbols")
map_tele("<leader>gr", "lsp_references")
map_tele("<leader>ld", "Telescope_diagnostic")
map_tele("<leader>ws", "lsp_workspace_symbols", { fname_width = 60 })

-- Notifications
map_tele("<leader>tn", "telescope_notify")

return map_tele
