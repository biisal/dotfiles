return {
	{ -- this is for catppuccin
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				color_overrides = {
					mocha = {
						text = "#ffffff",
						green = "#00FF49",
						yellow = "#EEFF00",
						red = "#FF0048",
						maroon = "#FF0460",
						teal = "#00FFD4",
						sky = "#19D5F7"
					}
				},
				custom_highlights = function(colors)
					return {
						["@module"] = { fg = "#89dceb" },
						["@variable"] = { fg = "#00FFA1" },
						["@constructor"] = { fg = "#00EEFF", style = { "bold" } },
						Include = { fg = "#FF00A0" },
					}
				end,
			})
			vim.cmd.colorscheme "catppuccin"
		end
	}
}
