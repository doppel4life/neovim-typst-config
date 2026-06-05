local opt = vim.opt

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.showmode = false

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.updatetime = 300
opt.completeopt = { "fuzzy", "menuone", "noinsert", "noselect" }

vim.opt.wrap           = false
vim.opt.swapfile       = false
vim.opt.undofile       = true

opt.termguicolors = true

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
