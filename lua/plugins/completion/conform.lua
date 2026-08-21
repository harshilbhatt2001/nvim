vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim", name = "conform" },
})

-- All formatter binaries come from the flake's runtimePkgs.
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescriptreact = { "prettier" },
		typescript = { "prettier" },
		markdown = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		python = { "black" },
		nix = { "alejandra" },
		rust = { "rustfmt" },
	},
	-- Filetypes without a formatter above fall back to LSP formatting,
	-- replacing the old bare vim.lsp.buf.format() BufWritePre autocmd.
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 1000,
	},
	undojoin = true,
})
