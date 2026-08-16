vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim", name = "which-key" },
})

require("which-key").setup({
	-- Look & feel
	preset = "modern", -- "classic" | "modern" | "helix"

	-- Delay (ms) before the popup shows. Kept generous so quick, muscle-memory
	-- key sequences fire without the popup ever flashing up. Explicit triggers
	-- (e.g. <leader>? below) still open instantly, they ignore this delay.
	delay = 500,

	-- Group / prefix labels shown in the popup.
	spec = {
		{ "<leader>s", group = "search" },
		{ "<leader>w", group = "workspace" },
		{ "g",         group = "goto" },
	},

	icons = {
		mappings = true, -- show icons next to mappings
		keys = {},       -- use default key icons (<CR>, <Tab>, ...)
	},

	-- Keys shown in the bottom help bar of the popup.
	keys = {
		scroll_down = "<c-d>",
		scroll_up = "<c-u>",
	},
})

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
