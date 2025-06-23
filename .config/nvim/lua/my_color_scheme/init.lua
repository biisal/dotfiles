local M = {}
function M.setup(opts)
	opts = opts or {}
	local is_transparent = opts.is_transparent
	local colors = {
		bg = "#141313",
		fg = "#ffffff",
		red = "#00b7ff",
		green = "#00FF49",
		yellow = "#EEFF00",
		blue = "#19D5F7",
		magenta = "#FF00A0",
		cyan = "#00EEFF",
		white = "#ebdbb2",
		black = "#282828",
	}

	local bg = is_transparent and "NONE" or colors.bg

	local highlights = {
		Normal = { bg = bg, fg = colors.fg },
		NormalFloat = { bg = bg, fg = colors.fg },
		FloatBorder = { bg = bg, fg = colors.fg },
		FloatTitle = { bg = bg, fg = colors.fg },
		WarningMsg = { bg = colors.red, fg = colors.white },
	}

	for group, options in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, options)
	end
end

return M
