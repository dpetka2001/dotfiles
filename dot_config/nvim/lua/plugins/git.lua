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
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      always_select_remote = "true",
      default_remote = { "upstream", "origin" },
    },
  },

  -- `nvim-cmp` related for git
  -- NOTE:
  --  ╭─────────────────────────────────────────────────╮
  --  │ Issues, PRs and mentions don't seem to work.    │
  --  │ Only mentions for commits which trigger by `:`. │
  --  ╰─────────────────────────────────────────────────╯
  {
    "nvim-cmp",
    dependencies = {
      {
        "petertriho/cmp-git",
        opts = {
          -- remotes = { "upstream" },
        },
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, #opts.sources + 1, {
        name = "git",
        priority = 500,
        group_index = 1,
      })
    end,
  },
}
