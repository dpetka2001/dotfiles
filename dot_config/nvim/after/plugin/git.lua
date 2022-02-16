local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

local nmap = require("jrn23.keymap").nmap

neogit.setup {
  kind = "replace",
  integrations = {
    diffview = true,
  },
}

nmap { "<space>vv", ":DiffviewOpen " }

--nmap { "<leader>gs", ":Neogit kind=replace<CR>" }
nmap { "<leader>git", neogit.open }
nmap {
  "<leader>gc",
  function()
    neogit.open { "commit" }
  end,
}
