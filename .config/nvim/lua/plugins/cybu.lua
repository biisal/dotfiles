return {
	"ghillb/cybu.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
	config = function()
		local cybu = require("cybu")

		cybu.setup({
			display_time = 2000,
			-- We removed the 'behavior' block here to prevent the 'nil value' error
			style = {
				-- Increase this number to show more buffers
				-- 5 will show the current + 2 above + 2 below
				-- 7 will show the current + 3 above + 3 below
				max_height = 11,

				-- Optional: make the window wider to see long filenames
				max_width = 1, -- 50% of screen width
			},
		})

		local is_active = false
		local timer = nil

		-- Logic: If UI is closed, move forward then back (shows UI, stays on buffer)
		-- If UI is already open, move normally.
		local function smart_cycle(direction)
			if not is_active then
				is_active = true
				cybu.cycle(direction)
				-- Immediate reverse to stay on the current buffer
				cybu.cycle(direction == "next" and "prev" or "next")
			else
				cybu.cycle(direction)
			end

			-- Reset the 'is_active' state after the popup disappears
			if timer then timer:stop() end
			timer = vim.defer_fn(function()
				is_active = false
			end, 2000) -- Matches your display_time
		end

		-- Map your keys to the smart_cycle function
		vim.keymap.set("n", "<Tab>", function() smart_cycle("next") end)
		vim.keymap.set("n", "<S-Tab>", function() smart_cycle("prev") end)
		vim.keymap.set("n", "<C-n>", function() smart_cycle("next") end)
		vim.keymap.set("n", "<C-p>", function() smart_cycle("prev") end)
	end,
}
