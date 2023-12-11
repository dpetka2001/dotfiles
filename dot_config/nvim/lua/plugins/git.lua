return {
  -- Alternative git-blame
  --[[ 
    WARN: 
--  ╭──────────────────────────────────────────────────────────╮
--  │ It has problems when scrolling rapidly, causes slowdown  │
--  │ See https://github.com/f-person/git-blame.nvim/issues/83 │
--  │     Disable it for now at start and call it manually     │
--  ╰──────────────────────────────────────────────────────────╯
--]]
  {
    "f-person/git-blame.nvim",
    -- event = "BufReadPre",
    cond = function()
      return vim.loop.fs_stat(vim.loop.cwd() .. "/.git") or vim.fn.finddir(".git", ";") ~= ""
    end,
    init = function()
      -- vim.g.gitblame_display_virtual_text = 0
      vim.g.gitblame_enabled = 0
    end,
  },

  -- Git messages(commits, history, etc)
  {
    "rhysd/git-messenger.vim",
    keys = {
      {
        "<leader>gm",
        function()
          vim.cmd("GitMessenger")
          -- call 2nd time with `defer_fn`, so that pop-up window opens and then
          -- are able to go into the window
          vim.defer_fn(function()
            vim.cmd("GitMessenger")
          end, 100)
        end,
        desc = "GitMessenger",
      },
    },
    cond = function()
      return vim.loop.fs_stat(vim.loop.cwd() .. "/.git") or vim.fn.finddir(".git", ";") ~= ""
    end,
    init = function()
      vim.g.git_messenger_no_default_mappings = true
    end,
    event = "BufRead",
  },

  -- Better `git commit`
  {
    "rhysd/committia.vim",
    -- event = "BufRead",
    cond = function()
      return vim.loop.fs_stat(vim.loop.cwd() .. "/.git") or vim.fn.finddir(".git", ";") ~= ""
    end,
    init = function()
      vim.g.committia_min_window_width = 130
      vim.g.committia_edit_window_width = 60
    end,
    keys = {
      { "<leader>gC", "<cmd>call committia#open('git')<cr>", desc = "Open Committia" },
    },
  },

  -- `gh`-like behavior from inside Neovim
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    cond = function()
      return vim.loop.fs_stat(vim.loop.cwd() .. "/.git") or vim.fn.finddir(".git", ";") ~= ""
    end,
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
