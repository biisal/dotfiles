vim.g.mapleader = " "

local map = vim.keymap.set

map("i", "jj", "<ESC>", { desc = "Escape" })


-- copy whole file to clipboard
map("n", "<C-c>", ":%y+<CR>", { desc = "Copy whole file to clipboard" })

-- showing digonostics
map("n", "<leader>g", vim.diagnostic.open_float)
map("n", "<leader>gn", vim.diagnostic.goto_next)
map("n", "<leader>gp", vim.diagnostic.goto_prev)

map("x", "p", "P")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local filetype = vim.bo.filetype
		if filetype == "json" then
			vim.cmd("%!jq '.'")
		else
			vim.lsp.buf.format()
		end
	end
})
