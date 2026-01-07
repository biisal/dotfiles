return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme tokyonight-night]])

		local bg_color = "#090B17"

		-- 1. Groups that just need the custom background (Text stays visible)
		local bg_only_groups = {
			"Normal", "NormalNC", "VertSplit", "StatusLine", "StatusLineNC",
			"TabLine", "TabLineFill", "TabLineSel", "SignColumn",
			"NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeWinSeparator"
		}

		for _, group in ipairs(bg_only_groups) do
			vim.api.nvim_set_hl(0, group, { bg = bg_color })
		end

		-- 2. Groups that should be INVISIBLE (Hides the white tildes/dots)
		local invisible_groups = {
			"NvimTreeEndOfBuffer", "EndOfBuffer"
		}

		for _, group in ipairs(invisible_groups) do
			-- We set FG to match BG so the character disappears
			vim.api.nvim_set_hl(0, group, { bg = bg_color, fg = bg_color })
		end
	end
}
