local opt = vim.opt

opt.guicursor = ""
opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true
opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 50

opt.isfname:append("@-@")

vim.cmd("silent! !mkdir -p " .. vim.fn.stdpath("data") .. "/undo")
