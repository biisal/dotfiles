return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			diagnostics = {
				enable = true,
				show_on_dirs = true, -- Shows icons on parent folders
				icons = {
					hint = "󰌵",
					info = "",
					warning = "",
					error = "",
				},
			},
			view = {
				number = true,
				relativenumber = true,
				signcolumn = "yes",
			}
		})
		local function toggle_tree_focus()
			local view = require("nvim-tree.view")
			if view.is_visible() and vim.api.nvim_get_current_win() == view.get_winnr() then
				-- If we are in the tree, jump back to the previous window
				vim.cmd("wincmd p")
			else
				-- If we aren't in the tree, jump into it
				vim.cmd("NvimTreeFocus")
			end
		end
		vim.keymap.set("n", "<D-b>", ":NvimTreeToggle<cr>")
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>")
		-- toggle focus
		vim.keymap.set("n", "<leader>o", toggle_tree_focus)
	end,
}
