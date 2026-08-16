vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	{ src = "https://github.com/ellisonleao/gruvbox.nvim", name = "gruvbox" },
	{ src = "https://github.com/paul-han-gh/tomorrow.nvim", name = "tomorrow" },
})

-- Rose Pine
require("rose-pine").setup({
	variant = "auto",      -- auto, main, moon, or dawn
	dark_variant = "moon", -- 'main', 'moon', 'dawn'
	dim_inactive_windows = false,
	extend_background_behind_borders = true,
	styles = {
		bold = true,
		italic = true,
		transparency = true,
	},
	highlight_groups = {
		Normal = { bg = nil },
		NormalFloat = { bg = nil },
	},
})

-- Gruvbox
require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true,
	contrast = "hard",
	transparent_mode = true,
	dim_inactive = false,
})

-- Tomorrow Night (active colourscheme, applied in init.lua)
require("tomorrow").setup({
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})
