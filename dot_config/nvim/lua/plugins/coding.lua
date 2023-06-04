return {
  -- Modify nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      { "windwp/nvim-autopairs", config = true },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        item.menu = ({
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          luasnip = "[LuaSnip]",
          path = "[Path]",
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
}
