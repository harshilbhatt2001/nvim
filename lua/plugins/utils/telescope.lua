vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim", name = "telescope-ui-select" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf" },
})

-- vim.pack only clones; fzf-native needs its C lib compiled once
-- (gnumake/gcc come from the flake's runtimePkgs).
local fzf_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf"
if vim.uv.fs_stat(fzf_dir) and not vim.uv.fs_stat(fzf_dir .. "/build/libfzf.so") then
	vim.fn.system({ "make", "-C", fzf_dir })
end

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

require("telescope").load_extension("ui-select")
pcall(require("telescope").load_extension, "fzf")
