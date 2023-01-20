local on_attach = require('lsp.setup')

require'lspconfig'.pylsp.setup{
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
