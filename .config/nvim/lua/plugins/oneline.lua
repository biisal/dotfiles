return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false
	},
	{ -- This helps with ssh tunneling and copying to clipboard
		"ojroques/vim-oscyank",
	},
	-- { -- Show css colors
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	lazy = true,
	-- 	config = function()
	-- 		require("colorizer").setup()
	-- 	end
	-- },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"amanbabuhemant/aneo.nvim",
		lazy = true,
		config = function()
			require("aneo").setup()
		end
	},
	-- wakatime
	{ 'wakatime/vim-wakatime', lazy = false },


}
