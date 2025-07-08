return { {
	'saghen/blink.cmp',
	dependencies = { 'L3MON4D3/LuaSnip' },
	version = '1.*',
	opts = {
		keymap = {
			['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
			['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
			["<CR>"] = { "accept", "fallback" },
			["<Esc>"] = { "hide", "fallback" },
			-- ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
			-- ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
		},
		appearance = {
			nerd_font_variant = 'mono'
		},
		completion = { documentation = { auto_show = true } },
		sources = {
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		signature = { enabled = true },
	},
} }
