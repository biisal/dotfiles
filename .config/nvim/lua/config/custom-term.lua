-- open floating terminal and run custom script to genrate git commit and pysh
function OpenFloatingTerminal()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local opts = {
		relative = 'editor',
		width = width,
		height = height,
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2,
		style = 'minimal',
		border = 'rounded',
	}
	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.fn.termopen("zsh -ic gc", { on_exit = function() vim.api.nvim_win_close(win, true) end })
	vim.cmd("startinsert")
end

vim.keymap.set('n', '<C-t>', OpenFloatingTerminal)
