vim.g.mapleader = " "

local map = vim.keymap.set

map("i", "jj", "<ESC>", { desc = "Escape" })
map("i", "JJ", "<ESC>", { desc = "Escape" })


-- copy whole file to clipboard
map("n", "<C-c>", ":%y+<CR>", { desc = "Copy whole file to clipboard" })
-- open comand mode using ;
map("n", ";", ":", { desc = "Open command mode" })
-- showing digonostics
map("n", "<leader>g", vim.diagnostic.open_float)
map("n", "<leader>gn", vim.diagnostic.goto_next)
map("n", "<leader>gp", vim.diagnostic.goto_prev)

vim.keymap.set('n', 'gd', function()
	local params = vim.lsp.util.make_position_params()
	local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
	local encoding = client and client.offset_encoding or "utf-16"

	vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result)
		if result and not vim.tbl_isempty(result) then
			vim.lsp.util.jump_to_location(result[1], encoding)
		else
			vim.lsp.buf_request(0, 'textDocument/implementation', params, function(_, impl_result)
				if impl_result and not vim.tbl_isempty(impl_result) then
					vim.lsp.util.jump_to_location(impl_result[1], encoding)
				else
					vim.notify("No definition or implementation found", vim.log.levels.WARN)
				end
			end)
		end
	end)
end, { desc = "Go to Definition or fallback to Implementation" })

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
