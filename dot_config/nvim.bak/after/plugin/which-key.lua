local wk = require('which-key')

---------------
-- Telescope --
---------------

wk.register({
  ["<leader>"] = {
    f = {
      name = "+file",
      n = { "<cmd>lua require('jrn23.telescope').edit_neovim()<CR>", "Edit Neovim" },
      d = { "<cmd>lua require('jrn23.telescope').edit_config()<CR>", "Edit dotfiles" },
      b = { "<cmd>RnvimrToggle<CR>", "Rnvimr File Manager" },
      f = { "<cmd>lua require('jrn23.telescope').search_all_files()<CR>", "Search all files" },
      g = { "<cmd>lua require('jrn23.telescope').multi_rg()<CR>", "Multi rip-grep" },
    },
    b = {
      name = "+buffers",
      o = { "<cmd>lua require('jrn23.telescope').oldfiles()<CR>", "Old Files" },
      l = { "<cmd>lua require('jrn23.telescope').buffers()<CR>", "List Buffers" },
    },
    v = {
      name = "+vim options",
      o = {"<cmd>lua require('jrn23.telescope').vim_options()<CR>", "Vim Options" },
      h = { "<cmd>lua require('jrn23.telescope').help_tags()<CR>", "Help tags" },
      m = { "<cmd>lua require('jrn23.telescope').manpages()<CR>", "Man Pages" },
      p = { "<cmd>lua require('jrn23.telescope').installed_plugins()<CR>", "Installed Plugins" },
    },
  }
})

---------
-- LSP --
---------

wk.register({

})
