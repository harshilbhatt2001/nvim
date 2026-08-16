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

-- Undo / swap
vim.opt.swapfile = false
vim.opt.backup = false

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.clipboard = "unnamed,unnamedplus"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.spell = true
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

require("plugins.init")
require("config.autocmd")
require("config.binds")
require("config.highlights")

vim.cmd.colorscheme("tomorrow-night")
