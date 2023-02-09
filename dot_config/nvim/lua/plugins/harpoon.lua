return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        silent = true,
        desc = "Add harpoon mark",
      },
      {
        "<C-e>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        silent = true,
        desc = "Harpoon toggle",
      },
    },
  },
}
