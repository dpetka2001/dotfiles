return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "markdown",
        "markdown_inline",
      })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
    },
    opts = function(_, opts)
      opts.symbol_in_winbar = {
        enable = false,
      }
      require("which-key").register({
        ["<leader>cs"] = {
          name = "+saga",
          ["s"] = "+diagnostics",
          ["["] = "+prev",
          ["]"] = "+next",
          ["c"] = "+code action",
          ["g"] = "+find/def/rename",
        },
      })
    end,
    keys = {
      -- LSP finder - Find the symbol's definition
      -- If there is no definition, it will instead be hidden
      -- When you use an action in finder like "open vsplit",
      -- you can use <C-t> to jump back
      { "<leader>csgh", "<cmd>Lspsaga lsp_finder<CR>", desc = "Lspsaga lsp_finder" },

      -- Code action
      { "<leader>csca", "<cmd>Lspsaga code_action<CR>", desc = "Lspsaga code_action" },

      -- Rename all occurrences of the hovered word for the entire file
      { "<leader>csgr", "<cmd>Lspsaga rename<CR>", desc = "Lspsaga rename" },

      -- Rename all occurrences of the hovered word for the selected files
      { "<leader>csgR", "<cmd>Lspsaga rename ++project<CR>", desc = "Lspsaga rename ++project" },

      -- Peek definition
      -- You can edit the file containing the definition in the floating window
      -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
      -- It also supports tagstack
      -- Use <C-t> to jump back
      { "<leader>csgp", "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga peek_definition" },

      -- Go to definition
      { "<leader>csgd", "<cmd>Lspsaga goto_definition<CR>", desc = "Lspsaga goto_definition" },

      -- Peek type definition
      -- You can edit the file containing the type definition in the floating window
      -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
      -- It also supports tagstack
      -- Use <C-t> to jump back
      { "<leader>csgt", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Lspsaga peek_type_definition" },

      -- Go to type definition
      { "<leader>csgT", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Lspsaga goto_type_definition" },

      -- Show line diagnostics
      -- You can pass argument ++unfocus to
      -- unfocus the show_line_diagnostics floating window
      { "<leader>cssl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Lspsaga show_line_diagnostics" },

      -- Show buffer diagnostics
      { "<leader>cssb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Lspsaga show_buf_diagnostics" },

      -- Show workspace diagnostics
      { "<leader>cssw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Lspsaga show_workspace_diagnostics" },

      -- Show cursor diagnostics
      { "<leader>cssc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Lspsaga show_cursor_diagnostics" },

      -- Diagnostic jump
      -- You can use <C-o> to jump back to your previous location
      { "<leader>cs[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Lspsaga diagnostic_jump_prev" },
      { "<leader>cs]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Lspsaga diagnostic_jump_next" },

      -- Diagnostic jump with filters such as only jumping to an error
      {
        "<leader>cs[E",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Lspsaga error_jump_prev",
      },
      {
        "<leader>cs]E",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Lspsaga error_jump_next",
      },

      -- Toggle outline
      { "<leader>cso", "<cmd>Lspsaga outline<CR>", desc = "Lspsaga Lspsaga outline" },

      -- Hover Doc
      -- If there is no hover doc,
      -- there will be a notification stating that
      -- there is no information available.
      -- To disable it just use ":Lspsaga hover_doc ++quiet"
      -- Pressing the key twice will enter the hover window
      { "<Leader>csK", "<cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga Lspsaga hover_doc" },

      -- If you want to keep the hover window in the top right hand corner,
      -- you can pass the ++keep argument
      -- Note that if you use hover with ++keep, pressing this key again will
      -- close the hover window. If you want to jump to the hover window
      -- you should use the wincmd command "<C-w>w"
      -- { "<Leader>csK", "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "Lspsaga Lspsaga hover_doc ++keep" },

      -- Call hierarchy
      { "<Leader>csci", "<cmd>Lspsaga incoming_calls<CR>", desc = "Lspsaga Lspsaga incoming_calls" },
      { "<Leader>csco", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Lspsaga Lspsaga outgoing_calls" },

      -- Floating terminal
      { "<A-d>", "<cmd>Lspsaga term_toggle<CR>", desc = "Lspsaga term_toggle" },
    },
  },
}
