vim.pack.add({
	{ src = "https://github.com/okuuva/auto-save.nvim", name = "autosave" },
	{ src = "https://github.com/vladdoster/remember.nvim", name = "remember" },
	{ src = "https://github.com/Aasim-A/scrollEOF.nvim", name = "scrolleof" },
})

-- NOTE: auto-save's writes go through conform's format_on_save (see
-- lua/plugins/completion/conform.lua) via the usual BufWritePre pipeline,
-- so files saved by autosave still get formatted on write like any other
-- explicit :w.
require("auto-save").setup({
	enabled = true,
	trigger_events = {
		immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
		defer_save = { "InsertLeave" }, -- save after debounce
		cancel_deferred_save = { "InsertEnter" }, -- cancel pending save
	},
	debounce_delay = 1000,
	noautocmd = true,
})

-- enable remember
require("remember").setup({})

-- enable scrolleof
require("scrollEOF").setup({
	-- The pattern used for the internal autocmd to determine
	-- where to run scrollEOF. See https://neovim.io/doc/user/autocmd.html#autocmd-pattern
	pattern = "*",
	-- Whether or not scrollEOF should be enabled in insert mode
	insert_mode = false,
	-- Whether or not scrollEOF should be enabled in floating windows
	floating = true,
	-- List of filetypes to disable scrollEOF for.
	disabled_filetypes = { "terminal" },
	-- List of modes to disable scrollEOF for. see https://neovim.io/doc/user/builtin.html#mode()
	disabled_modes = { "t", "nt" },
})

local autosave_group = vim.api.nvim_create_augroup("autosave", {})

-- Notification to say when a file is saved by autosave
vim.api.nvim_create_autocmd("User", {
	pattern = "AutoSaveWritePre",
	group = autosave_group,
	callback = function(opts)
		if opts.data.saved_buffer ~= nil then
			local filename = vim.fn.expand("%:t")
			print("Saved '" .. filename .. "' at " .. vim.fn.strftime("%H:%M:%S"))
		end
	end,
})

-- Notification when enabling/disabling autosave for a buffer
vim.api.nvim_create_autocmd("User", {
	pattern = "AutoSaveEnable",
	group = autosave_group,
	callback = function()
		print("AutoSave enabled")
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "AutoSaveDisable",
	group = autosave_group,
	callback = function()
		print("AutoSave disabled")
	end,
})
