return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup {
				automatic_enable = false,
				ensure_installed = {
					"lua_ls",
					"pyright",
					"vtsls",
					"gopls",
					"svelte",
					"tailwindcss",
					"cssls",
					"html",
					"pyrefly"
				},
				handlers = {},
			}
		end,
	},
}
