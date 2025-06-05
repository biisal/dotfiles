return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false
	},
	{ -- This is helps with ssh tunneling and copying to clipboard
		"ojroques/vim-oscyank",
	},
	{ -- Git Plugin
		"tpope/vim-fugitive"
	},
	{ -- Show css colors
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
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
