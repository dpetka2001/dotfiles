--require'lspconfig'.pyright.setup{}

--local util = require("lspconfig/util")
--local configs = require('lspconfig/configs')
local lspconfig = require('lspconfig')
local on_attach = require('jrn23.lsp.setup')

lspconfig.pyright.setup({
  on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
})
