return {
  {
    "numToStr/Comment.nvim",
    -- event = { "BufReadPost", "BufNewFile" },
    event = "LazyFile",
    opts = {
      ---Function to call before (un)comment
      -- FIX:
      --  ╭──────────────────────────────────────────────────────────╮
      --  │ Enclose the pre_hook in a function(closure), so          │
      --  │  that it can correctly be parsed by `lazy`,              │
      --  │ since `nvim-ts-context-commentstring` was removed        │
      --  │  by Lazyvim, thus not being                              │
      --  │ available while parsing the spec. By making it a         │
      --  │  closure, we defer it being required                     │
      --  │ until after `lazy` has loaded and parsed the spec.       │
      --  ╰──────────────────────────────────────────────────────────╯
      pre_hook = function()
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      end,
    },
  },

  {
    {
      "LudoPinelli/comment-box.nvim",
      event = "LazyFile",
      opts = {
        box_width = 70,
      },
    },
  },
}
