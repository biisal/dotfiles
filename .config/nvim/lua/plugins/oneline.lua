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
	-- {'romgrk/barbar.nvim',
	--    dependencies = {
	--      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
	--      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
	--    },
	--    init = function() vim.g.barbar_auto_setup = false end,
	--    opts = {
	--      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
	--      -- animation = true,
	--      -- insert_at_start = true,
	--      -- …etc.
	--    },
	--    version = '^1.0.0', -- optional: only update when a new 1.x version is released
	--  },
	-- {

	-- 	"amanbabuhemant/aneo.nvim",
	-- 	lazy = true,
	-- 	config = function()
	-- 		require("aneo").setup()
	-- 	end
	-- },
	-- wakatime
	-- { 'wakatime/vim-wakatime', lazy = false },


}
