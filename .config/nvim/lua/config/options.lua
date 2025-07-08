local option = vim.opt
option.number = true
--option.cursorline = true
option.tabstop = 4
option.relativenumber = true
option.shiftwidth = 4
option.clipboard = "unnamedplus"
option.termguicolors = true

vim.o.wrap = false
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
