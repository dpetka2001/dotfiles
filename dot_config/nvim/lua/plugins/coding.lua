local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")

return {
  -- Add `codeium.nvim`
  {
    "jcdickinson/codeium.nvim",
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
      { "windwp/nvim-autopairs", config = true },
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
        -- return item
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  -- Modify Luasnip
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = "lua/plugins/snippets" })
    end,
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
}
