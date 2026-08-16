-- telescope/plenary are also added here (idempotent) because this file loads
-- before utils/telescope.lua and needs telescope on the rtp for the extension.
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
	{ src = "https://github.com/ThePrimeagen/harpoon", name = "harpoon", version = "harpoon2" },
})

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
