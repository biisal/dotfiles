return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup {
				ensure_installed = {
					"lua_ls",
					"pyright",
					"vtsls",
					"gopls",
					"svelte",
					"tailwindcss",
					"cssls",
					"html",
				},
				handlers = {}, -- Disable automatic setup

			}
		end,
	},
}
