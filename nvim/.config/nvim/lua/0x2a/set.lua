vim.opt.guicursor = ""

vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "101"
--vim.opt.cursorline = true

vim.g.mapleader = " "

-- highlight matching braces
vim.opt.showmatch = true

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
--vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- open new split panes to right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.number = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "screenline"
