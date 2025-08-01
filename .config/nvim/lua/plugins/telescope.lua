return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')
		local builtin = require('telescope.builtin')

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
		})

		local map = vim.keymap.set
		map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		map('n', '<leader>cs', builtin.colorscheme, { desc = 'Telescope colorscheme' })
	end
}
