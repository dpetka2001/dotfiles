local fn = vim.fn

function _G.qftf(info)
  local items
  local ret = {}
  -- The name of item in list is based on the directory of quickfix window.
  -- Change the directory for quickfix window make the name of item shorter.
  -- It's a good opportunity to change current directory in quickfixtextfunc :)
  --
  -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
  -- local root = getRootByAlterBufnr(alterBufnr)
  -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
  --
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 31
  local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
  local validFmt = "%s │%5d:%-3d│%s %s"
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ""
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if fname == "" then
          fname = "[No Name]"
        else
          fname = fname:gsub("^" .. vim.env.HOME, "~")
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
      str = validFmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

return {
  -- Colorizer for showing colors from RBG values
  {
    -- TODO: check if https://github.com/NvChad/nvim-colorizer.lua/pull/63 will get merged

    -- "NvChad/nvim-colorizer.lua",
    -- dev = true,
    "dpetka2001/nvim-colorizer.lua",
    branch = "mehalter/master",
    ft = { "css", "html" },
    cmd = { "ColorizerToggle" },
    opts = {
      filetypes = {
        "css",
        "html",
      },
      user_default_options = {
        tailwind = true,
        mode = "inline",
        virtualtext = " ■",
      },
    },
  },

  -- Better scope for buffers throughout tabs
  {
    "tiagovla/scope.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    event = "LazyFile",
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
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
      { "<leader>gD", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffviewFileHistory Current File" },
    },
  },

  -- markdown preview
  {
    "toppair/peek.nvim",
    pin = true,
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
      spec = {
        ["<leader>p"] = { name = "+peek" },
      },
    },
  },

  -- Glance at definitions, refs, etc a la VS Code
  {
    "DNLHC/glance.nvim",
    -- event = "BufReadPre",
    event = "LazyFile",
    config = true,
    keys = {
      { "gD", "<cmd>Glance definitions<cr>", desc = "Goto Definitions (Glance)" },
      { "gR", "<cmd>Glance references<cr>", desc = "Goto References (Glance)" },
    },
  },

  -- Better surround for vim-visual-multi
  -- {
  --   "tpope/vim-surround",
  --   event = "LazyFile",
  -- },

  -- Observe how it behaves with vim-visual-multi instead of vim-surround
  {
    "kylechui/nvim-surround",
    event = "LazyFile",
    opts = {},
  },

  -- Better qflist??
  {
    "kevinhwang91/nvim-bqf",
    dependencies = {
      "junegunn/fzf",
      "junegunn/fzf.vim",
    },
    ft = { "qf" },
    opts = {
      filter = {
        fzf = {
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
        },
      },
    },
  },

  -- Mini-align
  {
    "echasnovski/mini.align",
    opts = {},
  },
}
