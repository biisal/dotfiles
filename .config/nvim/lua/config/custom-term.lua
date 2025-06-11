-- open floating terminal and run custom script to genrate git commit and pysh
local width = math.floor(vim.o.columns * 0.8)
local height = math.floor(vim.o.lines * 0.8)
local floating_term_win = nil
local floating_term_buf = nil

local opts = {
	relative = 'editor',
	width = width,
	height = height,
	row = (vim.o.lines - height) / 2,
	col = (vim.o.columns - width) / 2,
	style = 'minimal',
	border = 'rounded',
}

function AutoGitPushTerm()
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.fn.jobstart({ "zsh", "-ic", "gc" }, { term = true, on_exit = function() vim.api.nvim_win_close(win, true) end })
	vim.cmd("startinsert")
end

function FloatingTerm()
	if floating_term_win and vim.api.nvim_win_is_valid(floating_term_win) then
		vim.api.nvim_win_close(floating_term_win, true)
		floating_term_win = nil
		return
	elseif floating_term_buf and vim.api.nvim_buf_is_valid(floating_term_buf) then
		floating_term_win = vim.api.nvim_open_win(floating_term_buf, true, opts)
		vim.cmd("startinsert")
		return
	else
		floating_term_buf = vim.api.nvim_create_buf(false, true)
		floating_term_win = vim.api.nvim_open_win(floating_term_buf, true, opts)
		vim.fn.jobstart({ "zsh" }, { term = true })
		vim.cmd("startinsert")
	end
end

vim.keymap.set('n', '<C-y>', FloatingTerm)
vim.keymap.set('t', '<C-y>', FloatingTerm)
vim.keymap.set('n', '<C-t>', AutoGitPushTerm)
vim.keymap.set('t', '<C-v>', function()
	vim.cmd("stopinsert")
end)
