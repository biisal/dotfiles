return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			-- 1. Setup UI & Keymaps (LspAttach)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					-- Disable document color (if supported/enabled)
					-- Wrapped in pcall to prevent errors if server doesn't support it
					pcall(vim.lsp.document_color.enable, false, ev.buf)

					opts.desc = "Smart rename"
					vim.keymap.set("n", "gr", vim.lsp.buf.rename, opts)
				end,
			})

			-- 2. Define Servers & Configurations
			-- Add new servers here. If they need default config, just leave the table empty {}.
			local servers = {
				html = {},
				cssls = {},
				tailwindcss = {},
				-- svelte = {},
				emmet_language_server = {},
				eslint = {},
				clangd = {},
				bashls = {},
				-- Web Dev / Typescript

				-- tsserver = {
				-- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "json", "html" },
				-- 	settings = {
				-- 		javascript = {
				-- 			maxTsServerMemory = 512,
				-- 		}
				-- 	}
				-- },
				vtsls = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "json", "html" },
					settings = {
						javascript = {
							maxTsServerMemory = 512,
						}
					}
				},

				-- Python
				pyright = {
					filetypes = { "python" },
					settings = {
						python = {
							analysis = { typeCheckingMode = "basic" },
						},
					},
				},

				-- Go (Golang)
				gopls = {
					filetypes = { "go" },
					-- You can add gopls specific settings here for performance later
				},

				-- Lua
				lua_ls = {
					filetypes = { "lua" },
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
			}

			-- 3. Iterate and Setup
			for name, config in pairs(servers) do
				config.capabilities = capabilities
				lspconfig[name].setup(config)
			end
		end,
	},
}
