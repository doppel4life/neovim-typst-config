local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.showmode = true

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
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.termguicolors = true

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

