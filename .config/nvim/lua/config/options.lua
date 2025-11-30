local option = vim.opt
option.number = true
-- option.cursorline = true
option.tabstop = 4
option.relativenumber = true
option.shiftwidth = 4
option.clipboard = "unnamedplus"
option.termguicolors = true
option.winborder = "rounded"
option.signcolumn = "yes"
option.laststatus = 3
option.numberwidth = 1
vim.opt.cmdheight = 0
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- option.scrolloff = 2
--

option.foldenable = true
option.foldmethod = "indent"
option.foldlevel = 99

vim.o.wrap = false

vim.diagnostic.config {
	virtual_text = {
		prefix = "\t●",
		spacing = 4,
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
}
