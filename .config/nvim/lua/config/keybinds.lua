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


-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")

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
		if vim.bo.filetype ~= "json" then
			vim.lsp.buf.format()
			return
		end

		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		local input = table.concat(lines, "\n")

		local result = vim.system({ "jq", "." }, {
			stdin = input,
			text = true,
		}):wait()

		if result.code == 0 then
			local formatted = vim.split(result.stdout, "\n", { trimempty = true })
			vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted)
		else
			vim.notify("JSON syntax error: " .. result.stderr, vim.log.levels.ERROR)
		end
	end,
})
