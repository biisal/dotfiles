-- buffer tab
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local map = vim.keymap.set
			map("n", "<C-q>", function()
				local bufnr = vim.api.nvim_get_current_buf()
				vim.cmd("BufferLineCyclePrev")
				vim.cmd("bdelete " .. bufnr)
			end, { desc = "Close current buffer and go to previous" })
			map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
			map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
			require("bufferline").setup({
				options = {
					themable = true,
					mode = "buffers",
				}
			})
		end
	}
}
