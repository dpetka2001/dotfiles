return {
  -- Colorizer for showing colors from RBG values
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "html" },
    cmd = { "ColorizerToggle" },
    opts = {
      filetypes = {
        -- "css",
        -- "html",
      },
      user_default_options = {
        tailwind = true,
      },
    },
  },

  -- Better scope for buffers throughout tabs
  {
    "tiagovla/scope.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      restore_state = false,
    },
  },

  -- Better diffing
  {
    "sindrets/diffview.nvim",
    -- stylua: ignore start
    cmd = {
      "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles",
      "DiffviewFileHistory", "DiffviewRefresh"
    },
    -- stylua: ignore end
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },

  -- markdown preview
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>pp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    opts = { theme = "dark" },
  },

  -- which-key namespace
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>p"] = { name = "+peek" },
      },
    },
  },

  -- Glance at definitions, refs, etc a la VS Code
  {
    "DNLHC/glance.nvim",
    event = "BufReadPre",
    config = true,
    keys = {
      { "gD", "<cmd>Glance definitions<cr>", desc = "Goto Definitions (Glance)" },
      { "gR", "<cmd>Glance references<cr>", desc = "Goto References (Glance)" },
    },
  },
}
