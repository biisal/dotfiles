return {
	{
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
						["@tag"] = { fg = "#FC7AFF" },
						["@module"] = { fg = "#89dceb" },
						["@variable"] = { fg = "#ffffff" },
						["@constructor"] = { fg = "#00EEFF", style = { "bold" } },
						["@punctuation.bracket"] = { fg = "#f9e2af" },
						Include = { fg = "#FF00A0" },
						Function = { fg = "#FF0069", style = { "bold" } },
					}
				end,
			})
			vim.cmd.colorscheme "catppuccin"
		end
	}
}
