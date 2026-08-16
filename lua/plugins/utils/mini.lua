vim.pack.add({ { src = "https://github.com/echasnovski/mini.nvim", name = "mini" } })

require("mini.pairs").setup() -- Bracket pairs and stuff

require("mini.ai").setup() -- Around and In extension for text objects

-- Default `s`-prefixed mappings (sa/sd/sr/sf/sF/sh/sn) are kept on purpose;
-- they coexist with flash.nvim's `ss` jump bind.
require("mini.surround").setup() -- Surround selections with characters

require("mini.sessions").setup({ -- dir based session management
	autoread = true,
	autowrite = true,
	file = ".session",
	force = { read = false, write = true, delete = true },
})

-- Session keybinds
vim.keymap.set("n", "<leader>qj", function() -- quit and save session local
	require("mini.sessions").write(".session")
	vim.cmd("wqa")
end, { desc = "[Q]uit and save session" })

vim.keymap.set("n", "<leader>qd", function() -- quit and delete session
	require("mini.sessions").delete(".session")
	vim.cmd("wqa")
end, { desc = "[Q]uit and [D]elete session" })

vim.keymap.set("n", "<leader>fs", function() -- select session
	MiniSessions.select()
end, { desc = "[F]ind [S]ession" })

vim.keymap.set("n", "<leader>fd", function() -- delete session
	MiniSessions.select("delete")
end, { desc = "[F]ind session to [D]elete" })
