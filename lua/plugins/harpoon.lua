return { {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim", 
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- Telescope integration
    require("telescope").load_extension("harpoon")

    -- Keymaps
    vim.keymap.set("n", "<leader>mm", function()
      harpoon:list():add()
    end, { desc = "[M]ark file in Harpoon" })

    vim.keymap.set("n", "<leader>mh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "[M]enu [H]arpoon UI" })

    -- Jump to Harpoon file
    for i = 1, 4 do
      vim.keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end, { desc = "Harpoon file " .. i })
    end

    -- Telescope Harpoon picker
    vim.keymap.set("n", "<leader>mf", function()
      require("telescope").extensions.harpoon.marks()
    end, { desc = "[M]ark [F]ind with Telescope" })
  end,
},
}
