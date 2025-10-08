return {
	{
		"rafamadriz/friendly-snippets",
		config = function()
			local luasnip = require("luasnip")

			-- Load all default snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Load custom snippets from your config directory (optional)
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" }
			})
		end,
	}
}
