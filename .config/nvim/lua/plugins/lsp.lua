return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local keymap = vim.keymap
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					opts.desc = "Smart rename"
					keymap.set("n", "gr", vim.lsp.buf.rename, opts) -- smart rename
				end,
			})
			-- Lua LSP setup
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				filetypes = { "lua" },
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			-- eslint_d lsp
			lspconfig.eslint.setup({
				capabilities = capabilities,
			})
			-- clangd lsp
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			-- pyright lsp
			lspconfig.pyright.setup({
				capabilities = capabilities,
				filetypes = { "python" },
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
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
				filetypes = { "go" },
			})

			-- svelte lsp
			lspconfig.svelte.setup({
				capabilities = capabilities,
			})

			-- svelte lsp
			lspconfig.emmet_language_server.setup({
				capabilities = capabilities,
			})
		end,
	},
}
