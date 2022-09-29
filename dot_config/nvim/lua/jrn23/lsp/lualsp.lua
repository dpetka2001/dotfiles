local on_attach = require('jrn23.lsp.setup')
local sumneko_binary_path = vim.fn.exepath('lua-language-server')
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          -- Awesome WM related
          'awesome',
          'client',
          'root'
        },
        disable = { 'lowercase-global', 'unused-local', 'duplicate-index', 'undefined-global' },
      },
      workspace = {
        -- Increase preload files limit option
        maxPreload = 10000,
        preloadFileSize = 10000,
        -- Make the server aware of Neovim runtime files and Awesome WM Lua Api
        library = {
            '/usr/share/nvim/runtime/lua',
            '/usr/share/nvim/runtime/lua/lsp',
            '/usr/share/awesome/lib',
        -- vim.api.nvim_get_runtime_file("", true),
      }
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  },
},
}
