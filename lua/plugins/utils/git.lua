vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/sindrets/diffview.nvim", name = "diffview" },
	{ src = "https://github.com/NeogitOrg/neogit", name = "neogit" },
	{ src = "https://github.com/tpope/vim-fugitive", name = "fugitive" },
	{ src = "https://github.com/folke/todo-comments.nvim", name = "todo-comments" },
})

require("neogit").setup({})
require("todo-comments").setup()

-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local MyFugitive = vim.api.nvim_create_augroup("MyFugitive", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = MyFugitive,
	pattern = "*",
	callback = function()
		if vim.bo.ft ~= "fugitive" then
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "<leader>p", function()
			vim.cmd.Git("push")
		end, opts)

		-- rebase always
		vim.keymap.set("n", "<leader>P", function()
			vim.cmd.Git({ "pull", "--rebase" })
		end, opts)

		-- NOTE: It allows me to easily set the branch i am pushing and any tracking
		-- needed if i did not set the branch up correctly
		vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
	end,
})
