-- bootstrap lazy.nvim, LazyVim and your plugins

-- Add this here to disable lazyvim default options if you want
-- package.loaded["lazyvim.config.options"] = true

vim.loader.enable()
require("config.lazy")
