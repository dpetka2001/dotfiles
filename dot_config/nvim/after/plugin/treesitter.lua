require'nvim-treesitter.configs'.setup {
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<M-Space><M-n>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<M-Space><M-p>"] = "@parameter.inner",
      },
    },
  },
  highlight = {
    enable = true,
  },
}
