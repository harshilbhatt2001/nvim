vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/numToStr/FTerm.nvim", name = "fterm" },
	{ src = "https://github.com/greggh/claude-code.nvim", name = "claude-code" },
})

require("claude-code").setup()
