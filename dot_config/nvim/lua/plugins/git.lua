return {
  -- Alternative git-blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    init = function()
      vim.g.gitblame_display_virtual_text = 0
    end,
  },

  -- Git messages(commits, history, etc)
  {
    "rhysd/git-messenger.vim",
    init = function()
      vim.g.git_messenger_no_default_mappings = true
    end,
    event = "BufRead",
  },

  -- Better `git commit`
  {
    "rhysd/committia.vim",
    event = "BufRead",
    keys = {
      { "<leader>gC", "<cmd>call committia#open('git')<cr>", desc = "Open Committia" },
    },
  },

  -- `gh`-like behavior from inside Neovim
  -- { "pwntester/octo.nvim", cmd = "Octo", opts = {} },
}
