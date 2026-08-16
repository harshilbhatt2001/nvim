vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- Undo / swap: no swap or backup, but keep undo history across sessions
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(vim.opt.undodir:get()[1], "p")
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- Keep the cursor vertically centered-ish: half the screen, not a fixed 8
vim.opt.scrolloff = math.floor(vim.o.lines / 2) - 3
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.clipboard = "unnamed,unnamedplus"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.spell = true
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- Windows
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.o.winborder = "rounded"
vim.opt.cursorline = true

-- Local project config
vim.o.exrc = true

require("plugins.init")
require("config.autocmd")
require("config.binds")
require("config.highlights")

vim.cmd.colorscheme("tomorrow-night")
