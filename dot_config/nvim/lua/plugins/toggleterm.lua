local Util = require("lazyvim.util")

return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      -- { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "ToggleTerm (new tab)" },
      {
        "<leader>tp",
        -- "<Cmd>lua _G.input_result = vim.fn.input({ prompt = 'Enter: ' })<CR>",
        function()
          _G.input_result = vim.fn.input({ prompt = "Enter: " })
        end,
        desc = "ToggleTerm (prompt)",
      },
      {
        "<leader>th",
        function()
          require("toggleterm").toggle(tonumber(_G.input_result), 0, vim.loop.cwd(), "horizontal")
        end,
        desc = "ToggleTerm (horizontal)",
      },
      {
        "<leader>tv",
        function()
          require("toggleterm").toggle(tonumber(_G.input_result), 0, vim.loop.cwd(), "vertical")
        end,
        desc = "ToggleTerm (vertical)",
      },
      {
        "<leader>tn",
        "<cmd>ToggleTermSetName<cr>",
        desc = "Set term name",
      },
      {
        "<leader>ts",
        "<cmd>TermSelect<cr>",
        desc = "Select term",
      },
      {
        "<leader>tt",
        function()
          require("toggleterm").toggle(1, 100, Util.get_root(), "tab")
        end,
        desc = "ToggleTerm (root_dir)",
      },
      {
        "<leader>tT",
        function()
          require("toggleterm").toggle(1, 100, vim.loop.cwd(), "tab")
        end,
        desc = "ToggleTerm (cwd_dir)",
      },
    },
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = 20 or function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      -- on_open = fun(t: Terminal), -- function to run when the terminal opens
      -- on_close = fun(t: Terminal), -- function to run when the terminal closes
      -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
      -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
      -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = false,
      -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      direction = "horizontal" or "vertical" or "window" or "float",
      -- direction = "vertical",
      close_on_exit = true, -- close the terminal window when the process exits
      -- shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      -- float_opts = {
      --   -- The border key is *almost* the same as 'nvim_open_win'
      --   -- see :h nvim_open_win for details on borders however
      --   -- the 'curved' border is a custom border type
      --   -- not natively supported but implemented in this plugin.
      --   border = 'single' or 'double' or 'shadow' or 'curved',
      --   width = <value>,
      --   height = <value>,
      --   winblend = 3,
      --   highlights = {
      --     border = "Normal",
      --     background = "Normal",
      --   }
      -- }
    },
  },
}
