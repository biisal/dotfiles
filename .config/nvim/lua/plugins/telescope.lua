return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('telescope').setup({})
		local builtin = require('telescope.builtin')


		local map = vim.keymap.set
		map("n", "<leader>fg", builtin.git_files, {})
		map("n", "<leader>fr", builtin.live_grep, {})
		-- map("n", '<C-p>', builtin.find_files, {})
		map("n", "<leader>ff", builtin.find_files, {})
		map("n", "<leader>fb", builtin.buffers, {})
		map("n", "<leader>fh", ":Telescope find_files hidden=true <CR>")


		-- map('n', '<C-p>', function() builtin.find_files({ hidden = true, no_ignore = true }) end, { desc = 'Telescope find files' })
		-- map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		-- map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		-- map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		map('n', '<leader>cs', builtin.colorscheme, { desc = 'Telescope colorscheme' })

		map('n', '<leader>dd', builtin.diagnostics, { desc = 'Telescope workspace diagnostics' })
		map('n', '<leader>db', function()
			builtin.diagnostics({ bufnr = 0 })
		end, { desc = 'Telescope buffer diagnostics' })
	end
}
