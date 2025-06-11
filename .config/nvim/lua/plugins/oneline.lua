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
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"amanbabuhemant/aneo.nvim",
		config = function()
			require("aneo").setup()
		end
	}
}
