vim.g.mapleader = " "


local map = vim.keymap.set


map('n', '<C-n>', function()
	require('nvim-tree.api').tree.toggle()
end, { desc = 'Toggle NvimTree' })

map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-q>", function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.cmd("BufferLineCyclePrev")
	vim.cmd("bdelete " .. bufnr)
end, { desc = "Close current buffer and go to previous" })

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<C-s>", function()
	local filetype = vim.bo.filetype
	if filetype == "json" then
		vim.cmd("%!jq '.'")
	else
		vim.lsp.buf.format()
	end
	vim.cmd("w")
end, { desc = "Save and format file" })


-- copy whole file to clipboard
map("n", "<C-c>", ":%y+<CR>", { desc = "Copy whole file to clipboard" })

-- showing digonostics
map("n", "<leader>g", vim.diagnostic.open_float)
map("n", "<leader>gn", vim.diagnostic.goto_next)
map("n", "<leader>gp", vim.diagnostic.goto_prev)

map("x", "p", "P")
