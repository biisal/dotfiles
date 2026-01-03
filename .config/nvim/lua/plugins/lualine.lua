return {
	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = false,
			theme = 'tokyonight',
			component_separators = '|',
			section_separators = '',
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff', 'diagnostics' },
			lualine_c = { { 'filename', path = 1 } }, -- This line sets the full path
			lualine_x = { 'encoding', 'fileformat', 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { 'filename', path = 1 } }, -- Also sets full path for inactive windows
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
	},
}
