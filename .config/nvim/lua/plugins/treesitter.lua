return {
	'nvim-treesitter/nvim-treesitter',
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			autotags = { enable = true },
			ensure_installed = {
				"lua",
				"tsx",
				"python",
				"html",
				"css",
				"javascript",
				"json",
				"markdown",
				"markdown_inline",
				"yaml",
				"go"
			},
			auto_install = true,
		})
	end
}
