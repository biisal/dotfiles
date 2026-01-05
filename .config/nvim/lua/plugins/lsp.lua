return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			-- 1. Setup UI & Keymaps (LspAttach)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- Example: Correct way to toggle Inlay Hints if the server supports it
					if client and client.supports_method("textDocument/inlayHint", { bufnr = ev.buf }) then
						vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
					end

					opts.desc = "Smart rename"
					-- vim.keymap.set("n", "gr", vim.lsp.buf.rename, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
					vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
				end,
			})

			-- 2. Define Servers & Configurations
			local servers = {
				html = {},
				cssls = {},
				tailwindcss = {},
				emmet_language_server = {},
				eslint = {},
				clangd = {},
				bashls = {},
				vtsls = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "json", "html" },
					settings = {
						javascript = {
							maxTsServerMemory = 512,
						}
					}
				},
				pyright = {
					filetypes = { "python" },
					settings = {
						python = {
							analysis = { typeCheckingMode = "basic" },
						},
					},
				},
				gopls = {
					filetypes = { "go" },
				},
				lua_ls = {
					filetypes = { "lua" },
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
			}

			-- 3. Iterate and Setup using the new Native API
			for name, config in pairs(servers) do
				-- Merge capabilities into the config
				config.capabilities = capabilities

				-- Set the configuration for the server
				-- This replaces lspconfig[name].setup(config)
				vim.lsp.config(name, config)

				-- Enable the server (manages automatic launching/attaching)
				vim.lsp.enable(name)
			end
		end,
	},
}
