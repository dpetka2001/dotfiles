local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.dap.core" },
    -- { import = "lazyvim.plugins.extras.dap.nlua" },
    -- { import = "lazyvim.plugins.extras.coding.yanky" },
    -- { import = "lazyvim.plugins.extras.test.core" },
    -- { import = "lazyvim.plugins.extras.ui.edgy" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
    missing = false,
  },
  -- automatically check for plugin updates
  checker = {
    enabled = false,
    frequency = 14400,
  },
  ui = {
    custom_keys = {
      ["<localleader>l"] = {
        function(plugin)
          LazyVim.lazygit({ args = { "log" }, size = { width = 1.0, height = 1.0 }, cwd = plugin.dir })
        end,
        desc = "Open lazygit log",
      },
    },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  dev = {
    path = "~/projects/plugins/",
    -- patterns = { "LazyVim" },
  },
})
