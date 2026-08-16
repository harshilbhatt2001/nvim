vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim", name = "telescope-ui-select" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf" },
	{ src = "https://github.com/nvim-telescope/telescope-file-browser.nvim", name = "telescope-file-browser" },
})

-- vim.pack only clones; fzf-native needs its C lib compiled once
-- (gnumake/gcc come from the flake's runtimePkgs).
local fzf_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf"
if vim.uv.fs_stat(fzf_dir) and not vim.uv.fs_stat(fzf_dir .. "/build/libfzf.so") then
	vim.fn.system({ "make", "-C", fzf_dir })
end

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { ".git", "%.csv", ".venv", ".node_modules", "node_modules" },
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
	pickers = {
		-- <CR> jumps to the window/tab where the file is already open
		-- instead of opening a duplicate buffer
		buffers = {
			show_all_buffers = true,
			mappings = {
				i = {
					["<CR>"] = actions.select_drop,
				},
				n = {
					["<CR>"] = actions.select_drop,
					["d"] = actions.delete_buffer,
				},
			},
		},
		find_files = {
			mappings = {
				i = {
					["<CR>"] = actions.select_drop,
				},
				n = {
					["<CR>"] = actions.select_drop,
				},
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
		},
	},
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
pcall(require("telescope").load_extension, "fzf")

-- File browser at the current file's directory
vim.keymap.set("n", "<leader>fn", function()
	local full_path = vim.api.nvim_buf_get_name(0)
	local dir = vim.fn.fnamemodify(full_path, ":h")
	require("telescope").extensions.file_browser.file_browser({ path = dir })
end, { desc = "[F]ile [N]avigator" })
