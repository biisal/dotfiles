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
vim.opt.cursorline = false
-- vim.opt.cursorlineopt = "number"

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


-- Dynamic Kitty padding: 0 in Neovim, restore on exit
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
	callback = function()
		os.execute("kitty @ set-spacing padding=0")
	end
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	callback = function()
		os.execute("kitty @ set-spacing padding-h=10 padding-v=0")
	end
})
