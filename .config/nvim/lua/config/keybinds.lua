vim.g.mapleader = " "


local map = vim.keymap.set


map('n', '<C-n>', function()
	require('nvim-tree.api').tree.toggle()
end, { desc = 'Toggle NvimTree' })

map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<C-s>", function()
	local ok, _ = pcall(vim.lsp.buf.format, { async = true })
	if not ok then print("LSP format failed") end
	vim.cmd("w")
end, { desc = "Format and save" })


-- showing digonostics
map("n", "<leader>g", vim.diagnostic.open_float)
map("n", "<leader>gn", vim.diagnostic.goto_next)
map("n", "<leader>gp", vim.diagnostic.goto_prev)
