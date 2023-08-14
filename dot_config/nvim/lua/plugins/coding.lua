return {
  -- Add `codeium.nvim`
  {
    "jcdickinson/codeium.nvim",
    -- commit = "b1ff0d6c993e3d87a4362d2ccd6c660f7444599f",
    lazy = true,
    dependencies = {
      { "jcdickinson/http.nvim", build = "cargo build --workspace --release" },
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },

  -- Modify nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
        },
      },
      { "jcdickinson/codeium.nvim" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local types = require("cmp.types")

      -- Function to sort LSP snippets, so that they appear at the end of LSP suggestions
      local function deprioritize_snippet(entry1, entry2)
        if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return false
        end
        if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return true
        end
      end

      -- Insert `deprioritize_snippet` first in the `comparators` table, so that it has priority
      -- over the other default comparators
      table.insert(opts.sorting.comparators, 1, deprioritize_snippet)
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "codeium", priority = 50 },
      }))
      opts.mapping = cmp.mapping.preset.insert(vim.tbl_deep_extend("force", opts.mapping, {
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ["<c-q>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }))
      opts.preselect = cmp.PreselectMode.None
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }
      opts.formatting.format = function(entry, item)
        local icons = require("lazyvim.config").icons.kinds
        local item = item
        if entry.source.name == "codeium" then
          item.kind = "   (Codeium)"
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            item.kind = "   (" .. entry.completion_item.data.detail .. ")"
          end
        end
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        item.menu = ({
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          luasnip = "[LuaSnip]",
          path = "[Path]",
          codeium = "[A.I.]",
        })[entry.source.name]

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
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip").filetype_extend("c", { "cdoc" })
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").load({ paths = "lua/plugins/snippets" })
      end,
    },
  },

  -- Easily create annotations
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },

  -- Refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
        desc = "Refactor",
      },
    },
    opts = {},
  },
}
