return {
	"folke/tokyonight.nvim",
	dependencies = { "nvim-tree/nvim-tree.lua" },
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd([[colorscheme tokyonight-night]])
		vim.cmd [[hi Normal guibg=#090B17]]
		vim.cmd [[hi NormalNC guibg=#090B17]]
		vim.cmd [[hi VertSplit guibg=#090B17]]
		vim.cmd [[hi StatusLine guibg=#090B17]]
		vim.cmd [[hi StatusLineNC guibg=#090B17]]
		vim.cmd [[hi TabLine guibg=#090B17]]
		vim.cmd [[hi TabLineFill guibg=#090B17]]
		vim.cmd [[hi TabLineSel guibg=#090B17]]
		vim.cmd [[hi SignColumn guibg=#090B17]]
	end
}
