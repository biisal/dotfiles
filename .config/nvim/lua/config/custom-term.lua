-- open floating terminal and run custom script to genrate git commit and pysh
local width = math.floor(vim.o.columns * 0.8)
local height = math.floor(vim.o.lines * 0.8)
local floating_term_win = nil
local floating_term_buf = nil

local file_commands_prefix = {
	python = "python",
	go = "go run",
	text = "cat",
	node = "node",
	bun = "bun run"
}

local opts = {
	relative = 'editor',
	width = width,
	height = height,
	row = (vim.o.lines - height) / 2,
	col = (vim.o.columns - width) / 2,
	style = 'minimal',
	border = 'rounded',
}

function AutoGitPushTerm(shell, command)
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.fn.jobstart({ shell, "-ic", command },
		{ term = true, on_exit = function() vim.api.nvim_win_close(win, true) end })
	vim.cmd("startinsert")
end

function FloatingTerm(run_code)
	run_code = run_code or false
	local file_name, file_type = "", ""
	if run_code then
		file_type = vim.bo.filetype
		if file_type == "go" then
			file_name = "."
		else
			file_name = vim.fn.expand("%")
		end
	end
	if floating_term_win and vim.api.nvim_win_is_valid(floating_term_win) then
		vim.api.nvim_win_close(floating_term_win, true)
		floating_term_win = nil
		return
	elseif floating_term_buf and vim.api.nvim_buf_is_valid(floating_term_buf) then
		floating_term_win = vim.api.nvim_open_win(floating_term_buf, true, opts)
		if run_code then
			local command = file_commands_prefix[file_type]
			if command and command ~= "" then
				command = command .. " " .. file_name .. "\n"
				vim.fn.chansend(vim.b.terminal_job_id, command)
			end
		end
		vim.cmd("startinsert")
		return
	else
		floating_term_buf = vim.api.nvim_create_buf(false, true)
		floating_term_win = vim.api.nvim_open_win(floating_term_buf, true, opts)
		vim.fn.jobstart({ "zsh" }, { term = true })
		if run_code then
			local command = file_commands_prefix[file_type]
			if command and command ~= "" then
				command = command .. " " .. file_name .. "\n"
				vim.fn.chansend(vim.b.terminal_job_id, command)
			end
		end
		vim.cmd("startinsert")
	end
end

vim.keymap.set('n', '<C-y>', FloatingTerm)
vim.keymap.set('t', '<C-y>', FloatingTerm)
vim.keymap.set("n", "<F2>", function()
	FloatingTerm(true)
end)
vim.keymap.set("t", "<F2>", FloatingTerm)

vim.keymap.set('n', '<C-t>', function()
	AutoGitPushTerm("zsh", "gc")
end)
vim.keymap.set('n', '<C-g>', function()
	AutoGitPushTerm("sh", "godo")
end)
vim.keymap.set('t', '<C-v>', function()
	vim.cmd("stopinsert")
end)
