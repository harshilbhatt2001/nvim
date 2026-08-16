-- main-branch rewrite: no more configs.setup(); the plugin only manages
-- parser installation, highlighting is started per-buffer below.
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter", version = "main" },
})

require("nvim-treesitter").install({
	"markdown",
	"markdown_inline",
	"lua",
	"rust",
	"toml",
	"json",
	"yaml",
	"bash",
	"vim",
	"vimdoc",
	-- noice.nvim needs these for cmdline/message highlighting
	"regex",
})

-- Enable treesitter highlighting + indentation for any buffer that has
-- a parser for its filetype (pcall: no parser -> plain highlighting).
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if pcall(vim.treesitter.start, args.buf) then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
