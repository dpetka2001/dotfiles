local nmap = require("jrn23.keymap").nmap

local silent = { silent = true }

nmap { "<leader>a", function() require("harpoon.mark").add_file() end, silent }
nmap { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, silent }
