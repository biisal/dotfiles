vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
	callback = function()
		vim.cmd("redrawstatus")
	end
})

-- Simple diagnostic count function
local function diagnostic_count()
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

	local parts = {}
	if errors > 0 then table.insert(parts, "E" .. errors) end
	if warnings > 0 then table.insert(parts, "W" .. warnings) end

	return #parts > 0 and "[" .. table.concat(parts, "|") .. "]" or ""
end

_G.diagnostic_count = diagnostic_count
vim.opt.statusline = "%f %m%=     %{v:lua.diagnostic_count()} %l,%c %P"
