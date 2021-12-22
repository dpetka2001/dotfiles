local cmp = require('cmp')
cmp.setup {
  -- Snippet engine
  snippet = {
    expand = function(args)
      -- For `luasnip' user
      require('luasnip').lsp_expand(args.body)
    end
  },

  -- You can set mapping if you want.
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'path' },
    { name = 'nvim-lua' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
  },

  -- Make it auto-complete like nvim-compe
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },

  -- Add names for sources specified
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}
require'lspconfig'.pyright.setup {
  capabilities = capabilities,
}
