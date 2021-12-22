local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_mt = require("telescope.actions.mt")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

-- Recipe for disabling the previewer for binary files (taken from Telescope's
-- Wiki)
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				-- maybe we want to write something to the buffer here
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				end)
			end
		end
	}):sync()
end

require("telescope").setup{
	defaults = {
		prompt_prefix = "$ ",
		-- prompt_position = "top",
		sorting_strategy = "ascending",
		buffer_previewer_maker = new_maker,
		scroll_strategy = "limit",
		-- path_display = "smart",
		selection_caret = "> ",
		layout_config = {
			prompt_position = "top",
		},
	},
	pickers = {
		-- Your special builtin config goes in here
		buffers = {
			-- sort_lastused = true,
			-- theme = "dropdown",
			-- previewer = false,
			initial_mode = "normal",
			mappings = {
				i = {
					["<c-r>"] = require("telescope.actions").delete_buffer,
					-- or right hand side can also be a the name of the action as string
					["<c-r>"] = "delete_buffer"
				},
				n = {
					["<c-r>"] = require("telescope.actions").delete_buffer,
				}
			}
		},
		oldfiles = {
				-- initial_mode = "normal",
		},
		find_files = {
				-- find_command = { 'rg', '--hidden', '--files' },
				find_command = { 'rg', '--files' },
				mappings = {
					i = {
						-- ["<c-a>"] = function() vim.cmd ":norm! I" end,
						-- ["<c-e>"] = function() vim.cmd ":norm! A " end,
						["<c-u>"] = function() vim.cmd ":norm! d0" end,
						["<c-b>"] = function() vim.cmd ":norm! b" end,
						["<c-f>"] = function() vim.cmd ":norm! w" end,
						["<c-w>"] = function() vim.cmd ":norm! db" end,
					}
				}
		--	 theme = "dropdown"
		},
	},
}

require("telescope").load_extension("fzf")
require("telescope").load_extension("notify")
