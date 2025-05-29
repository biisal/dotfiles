return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {
	    "saghen/blink.cmp",
	},
	config = function()
	    local capabilities = require('blink.cmp').get_lsp_capabilities()
	    local lspconfig = require("lspconfig")
	    -- Lua LSP setup
	    lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
		    Lua = {
			diagnostics = {
			    globals = { "vim" },
			},
		    },
		},
	    })

	    -- Pyright LSP setup with strict mode
	    lspconfig.pyright.setup({
		capabilities = capabilities,
		settings = {
		    python = {
			analysis = {
			    typeCheckingMode = "strict",
			},
		    },
		},
	    })
	    -- vtsls lsp
	    lspconfig.vtsls.setup({
		capabilities = capabilities,
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "json", "html" },
	    })

	    -- html lsp
	    lspconfig.html.setup({
		capabilities = capabilities,
	    })

	    -- css lsp
	    lspconfig.cssls.setup({
		capabilities = capabilities,
	    })

	    -- tailwindcss lsp
	    lspconfig.tailwindcss.setup({
		capabilities = capabilities,
	    })
	    -- gopls lsp
	    lspconfig.gopls.setup({
		capabilities = capabilities,
		settings = {
		    gopls = {
			analyses = {
			    unusedparams = true,
			},
			staticcheck = true,
		    },
		},
	    })

	    -- svelte lsp
	    lspconfig.svelte.setup({
		capabilities = capabilities,
	    })
	end,
    },
}
