local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_layout = require "telescope.actions.layout"
local transform_mod = require("telescope.actions.mt").transform_mod
local fb_actions = require "telescope".extensions.file_browser.actions

-- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1220846367
local function multiopen(prompt_bufnr, method)
    local cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        tab = "tabe",
        default = "edit"
    }
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 0 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
            -- opinionated use-case
            local cmd = i == 1 and "edit" or cmd_map[method]
            vim.cmd(string.format("%s %s", cmd, entry.value))
        end
    else
        actions["select_" .. method](prompt_bufnr)
    end
end

local custom_actions = transform_mod({
    multi_selection_open_vertical = function(prompt_bufnr)
        multiopen(prompt_bufnr, "vertical")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
        multiopen(prompt_bufnr, "horizontal")
    end,
    multi_selection_open_tab = function(prompt_bufnr)
        multiopen(prompt_bufnr, "tab")
    end,
    multi_selection_open = function(prompt_bufnr)
        multiopen(prompt_bufnr, "default")
    end,
})

local function stopinsert(callback)
    return function(prompt_bufnr)
        vim.cmd.stopinsert()
        vim.schedule(function()
            callback(prompt_bufnr)
        end)
    end
end

local multi_open_mappings = {
    i = {
        ["<C-v>"] = stopinsert(custom_actions.multi_selection_open_vertical),
        ["<C-s>"] = stopinsert(custom_actions.multi_selection_open_horizontal),
        ["<C-t>"] = stopinsert(custom_actions.multi_selection_open_tab),
        ["<CR>"]  = stopinsert(custom_actions.multi_selection_open)
    },
    n = {
        ["<C-v>"] = custom_actions.multi_selection_open_vertical,
        ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
        ["<C-t>"] = custom_actions.multi_selection_open_tab,
        ["<CR>"] = custom_actions.multi_selection_open,
    },
}

require("telescope").setup {
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    preview = false,
    previewer = false,

    winblend = 0,

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "limit",
    color_devicons = true,

    mappings = {
      i = {
        ["<C-x>"] = actions.toggle_selection,
        ["<C-r>"] = "delete_buffer",
      },
      n = {
        ["<C-x>"] = actions.toggle_selection,
        ["<C-r>"] = "delete_buffer",
      },
    },

    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    -- file_ignore_patterns = nil,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    history = {
      path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
      limit = 100,
    },
  },

  pickers = {
    buffers = {
      theme = "dropdown",
      mappings = multi_open_mappings
    },

    oldfiles = {
      --initial_mode = "normal",
      mappings = multi_open_mappings
    },

    fd = {
      mappings = multi_open_mappings
    },

    git_branches = {
      mappings = {
        i = {
          ["<C-a>"] = false,
        },
      },
    },


  },

  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },

    fzf_writer = {
      use_highlighter = false,
      minimum_grep_characters = 6,
    },

    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
    },

    -- frecency = {
    --   workspaces = {
    --     ["conf"] = "/home/tj/.config/nvim/",
    --     ["nvim"] = "/home/tj/build/neovim",
    --   },
    -- },
  },
}

-- _ = require("telescope").load_extension "dap"
_ = require('telescope').load_extension('file_browser')
_ = require("telescope").load_extension "notify"
_ = require("telescope").load_extension "ui-select"
_ = require("telescope").load_extension "fzf"
_ = require("telescope").load_extension "fzy_native"
-- _ = require("telescope").load_extension "git_worktree"
-- _ = require("telescope").load_extension "neoclip"
_ = require("telescope").load_extension "frecency"
_ = require("telescope").load_extension "smart_history"

if vim.fn.executable "gh" == 1 then
  pcall(require("telescope").load_extension, "gh")
  pcall(require("telescope").load_extension, "octo")
end

-- LOADED_FRECENCY = LOADED_FRECENCY or true
-- local has_frecency = true
-- if not LOADED_FRECENCY then
--   if not pcall(require("telescope").load_extension, "frecency") then
--     require "tj.telescope.frecency"
--   end

--   LOADED_FRECENCY = true
-- end
