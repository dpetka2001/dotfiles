return {
  -- Codeium.vim
  -- {
  --   "Exafunction/codeium.vim",
  --   lazy = true,
  --   init = function()
  --     vim.g.codeium_filetypes = {
  --       TelescopePrompt = false,
  --       ["neo-tree-popup"] = false,
  --       ["dap-repl"] = false,
  --     }
  --   end,
  --   config = function()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set("i", "<C-g>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-;>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-z>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true, silent = true })
  --   end,
  -- },

  -- Test out `neocodeium`
  -- {
  --   "monkoose/neocodeium",
  --   event = "VeryLazy",
  --   config = function()
  --     local neocodeium = require("neocodeium")
  --     neocodeium.setup({
  --       filetypes = {
  --         TelescopePrompt = false,
  --         ["neo-tree-popup"] = false,
  --         ["dap-repl"] = false,
  --       },
  --     })
  --     -- stylua: ignore start
  --     vim.keymap.set("i", "<C-g>", function() neocodeium.accept() end)
  --     vim.keymap.set("i", "<C-j>", function() neocodeium.accept_word() end)
  --     vim.keymap.set("i", "<C-l>", function() neocodeium.accept_line() end)
  --     vim.keymap.set("i", "<C-;>", function() neocodeium.cycle_or_complete() end)
  --     vim.keymap.set("i", "<C-,>", function() neocodeium.cycle_or_complete(-1) end)
  --     vim.keymap.set("i", "<C-z>", function() neocodeium.clear() end)
  --     -- stylua: ignore end
  --   end,
  -- },

  -- Modify nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- { "Exafunction/codeium.vim" },
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
        },
      },
      { "hrsh7th/cmp-calc" },
      {
        "garymjr/nvim-snippets",
        opts = {
          search_paths = { vim.fn.stdpath("config") .. "/misc/snippets" },
        },
      },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      -- local types = require("cmp.types")

      -- Function to sort LSP snippets, so that they appear at the end of LSP suggestions
      -- local function deprioritize_snippet(entry1, entry2)
      --   if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
      --     return false
      --   end
      --   if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
      --     return true
      --   end
      -- end

      -- Insert `deprioritize_snippet` first in the `comparators` table, so that it has priority
      -- over the other default comparators
      -- table.insert(opts.sorting.comparators, 1, deprioritize_snippet)

      -- Insert parentheses after selecting method/function
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Make codeium suggestions appear only when `nvim-cmp` menu is closed
      -- local neocodeium = require("neocodeium")
      -- local commands = require("neocodeium.commands")
      -- cmp.event:on("menu_opened", function()
      --   commands.disable()
      --   neocodeium.clear()
      --   -- vim.g.codeium_manual = true
      --   -- vim.fn["codeium#Clear"]()
      -- end)
      -- cmp.event:on("menu_closed", function()
      --   commands.enable()
      --   neocodeium.cycle_or_complete()
      --   -- vim.g.codeium_manual = false
      --   -- vim.fn["codeium#Complete"]()
      -- end)

      -- Take care of source ordering and group_index
      table.insert(opts.sources, #opts.sources + 1, { name = "calc", priority = 650, group_index = 2 })

      opts.preselect = cmp.PreselectMode.None
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
        -- autocomplete = false,
      }

      -- Set highlight group and window options for nvim-cmp
      vim.api.nvim_set_hl(0, "PopMenu", { bg = "#1F2335", blend = 0 })
      local win_opt = {
        col_offset = 0,
        side_padding = 1,
        winhighlight = "Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }
      -- Add border to completion and docs
      opts.window = {
        completion = cmp.config.window.bordered(win_opt),
        documentation = cmp.config.window.bordered(win_opt),
      }

      -- Set view to follow cursor while typing
      opts.view = {
        entries = {
          follow_cursor = true,
        },
      }

      -- original Lazyvim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        local item = item
        format_kinds(entry, item) -- add icons

        --[[ Make completion width dynamic according to window width ]]
        -- See https://github.com/hrsh7th/nvim-cmp/discussions/609

        -- Set the fixed width of the completion menu to 60 characters.
        -- fixed_width = 20

        -- Set 'fixed_width' to false if not provided.
        fixed_width = fixed_width or false

        -- Get the completion entry text shown in the completion window.
        local content = item.abbr

        -- Set the fixed completion window width.
        if fixed_width then
          vim.o.pumwidth = fixed_width
        end

        -- Get the width of the current window.
        local win_width = vim.api.nvim_win_get_width(0)

        -- Set the max content width based on either: 'fixed_width'
        -- or a percentage of the window width, in this case 20%.
        -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
        local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.25)

        -- Truncate the completion entry text if it's longer than the
        -- max content width. We subtract 3 from the max content width
        -- to account for the "..." that will be appended to it.
        if #content > max_content_width then
          item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
        else
          item.abbr = content .. (" "):rep(max_content_width - #content)
        end

        -- return item
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  -- Modify Luasnip
  -- {
  --   "L3MON4D3/LuaSnip",
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     config = function()
  --       require("luasnip").filetype_extend("c", { "cdoc" })
  --       require("luasnip.loaders.from_vscode").lazy_load()
  --       require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
  --     end,
  --   },
  --   opts = {
  --     -- WARN:
  --     --  ╭──────────────────────────────────────────────────────────╮
  --     --  │ As snippets are not removed when their text is           │
  --     --  │  deleted, they have to be removed manually               │
  --     --  │ via LuasnipUnlinkCurrent if `delete_check_events`        │
  --     --  │  is not enabled. This can cause false                    │
  --     --  │ positives with `Tab` when in insert mode and jump        │
  --     --  │  you around in strange positions in the                  │
  --     --  │ buffer, thinking that it jumps inside a snippet.         │
  --     --  ╰──────────────────────────────────────────────────────────╯
  --     delete_check_events = { "TextChanged", "InsertLeave" },
  --   },
  -- },
}
