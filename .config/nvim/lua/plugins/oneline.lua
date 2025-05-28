return {
	{ -- This is helps with ssh tunneling and copying to clipboard
		"ojroques/vim-oscyank",
	},
	{ -- Git Plugin
		"tpope/vim-fugitive"
	},
	{ -- Show css colors
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end
	},
	{
		"folke/neodev.nvim",
		lazy = true,
		config = function()
			require("neodev").setup({})
		end,
	},
	{
		"amanbabuhemant/aneo.nvim",
		config = function()
			require("aneo").setup()
		end
	}
}
