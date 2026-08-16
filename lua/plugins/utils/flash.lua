vim.pack.add({
	{ src = "https://github.com/folke/flash.nvim", name = "flash" },
})

require("flash").setup()

vim.keymap.set("n", "ss", function()
	require("flash").jump({
		search = {
			mode = "fuzzy",
		},
		highlight = {
			backdrop = true,
		},
	})
end, { desc = "Flash jump" })

vim.keymap.set("n", "S", function()
	require("flash").treesitter()
end, { desc = "Flash treesitter" })

-- NOTE: reference config binds these to <leader>r / <leader>R, but this
-- config already uses <leader>rn for LSP rename, so flash's remote/
-- treesitter_search pickers are moved to <leader>fr / <leader>fR instead.
vim.keymap.set("n", "<leader>fr", function()
	require("flash").remote()
end, { desc = "Flash remote" })

vim.keymap.set("n", "<leader>fR", function()
	require("flash").treesitter_search()
end, { desc = "Flash treesitter search" })
