-- buffer tab
return {
	{
	    "akinsho/bufferline.nvim",
	    version = "*",
	    dependencies = { "nvim-tree/nvim-web-devicons" },
	    config = function()
		require("bufferline").setup ({
		options = {
		    themable = true,
		    mode = "buffers",
		    }
		})
	    end
	}
    }
