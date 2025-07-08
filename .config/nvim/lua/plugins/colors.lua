return {
	{
		dir = "~/Desktop/nvim/blackhole/",
		-- "biisal/blackhole",
		priority = 1000,
		config = function()
			require("blackhole").setup({ transparent = true })
		end,
	}

}
