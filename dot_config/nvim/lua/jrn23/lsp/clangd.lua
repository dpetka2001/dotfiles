local on_attach = require('jrn23.lsp.setup')

require('lspconfig').clangd.setup{
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
