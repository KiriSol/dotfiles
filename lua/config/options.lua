vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

vim.opt.cursorline = true

vim.opt.scrolloff = 5
vim.opt.showmode = false

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.smarttab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.termguicolors = true

vim.opt.splitbelow = false
vim.opt.splitright = true

vim.opt.clipboard = "unnamedplus"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.opt.winborder = "rounded"

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})
