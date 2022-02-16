SHOULD_RELOAD_TELESCOPE = true

local reloader = function()
  if SHOULD_RELOAD_TELESCOPE then
    RELOAD "plenary"
    RELOAD "telescope"
    RELOAD "jrn23.telescope.setup"
    RELOAD "jrn23.telescope.custom"
  end
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local _ = pcall(require, "nvim-nonicons")

local M = {}

function M.edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ dotfiles nvim ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },

    mappings = {
      i = {
        ["<C-y>"] = false,
      },
    },

    attach_mappings = function(_, map)
      map("i", "<c-y>", set_prompt_to_entry_value)
      map("i", "<M-c>", function(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.schedule(function()
          require("telescope.builtin").find_files(opts_without_preview)
        end)
      end)

      return true
    end,
  }

  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  require("telescope.builtin").find_files(opts_with_preview)
end

function M.edit_config()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.config/",
    prompt_title = "~ dotfiles ~",
    hidden = true,

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.55,
    },
  }
end

function M.fd()
  local opts = themes.get_ivy { hidden = false, sorting_strategy = "ascending" }
  require("telescope.builtin").fd(opts)
end

-- function M.fs()
--   local opts = themes.get_ivy { hidden = false, sorting_strategy = "descending" }
--   require("telescope.builtin").fd(opts)
-- end

function M.installed_plugins()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath "config" .. "/plugged/",
  }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    -- winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require("telescope.builtin").help_tags {
    show_version = true,
  }
end

function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--no-ignore", "--files" },
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.vim_options()
  require("telescope.builtin").vim_options {
    layout_config = {
      width = 0.5,
    },
    sorting_strategy = "ascending",
  }
end

function M.lsp_references()
  require("telescope.builtin").lsp_references {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
end

function M.lsp_document_symbols()
  require("telescope.builtin").lsp_document_symbols {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
end

function M.oldfiles()
  require("telescope").extensions.frecency.frecency(themes.get_ivy {
    initial_mode = "normal",
  })
end

function M.buffers()
  require("telescope.builtin").buffers {
    shorten_path = false,
    initial_mode = "normal",
  }
end

function M.manpages()
  require("telescope.builtin").man_pages {
    sections = { "ALL" }
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    local has_custom, custom = pcall(require, string.format("jrn23.telescope.custom.%s", k))

    if M[k] then
      return M[k]
    elseif has_custom then
      return custom
    else
      return require("telescope.builtin")[k]
    end
  end,
})
