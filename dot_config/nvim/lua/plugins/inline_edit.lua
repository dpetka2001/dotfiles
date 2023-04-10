return {
  -- Plugin for editing <script> tags in html files in proxy buffer
  -- which also provides support for correct attach `typescript` LSP
  {
    "AndrewRadev/inline_edit.vim",
    cmd = { "InlineEdit" },
    keys = {
      { "<leader>cI", "<cmd>InlineEdit<cr>", desc = "Inline Edit (JS inside <script> html)" },
    },
    config = true,
  },
}
