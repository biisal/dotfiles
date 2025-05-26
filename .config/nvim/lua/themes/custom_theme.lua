local M = {}

-- Your colors
local colors = {
  white = "#FFFFFF",
  black = "#1E1D2D",
  one_bg = "#2d2c3c",
  one_bg2 = "#363545",
  grey = "#474656",
  grey_fg = "#4e4d5d",
  red = "#FF0031",
  green = "#47FF9C",
  blue = "#89B4FA",
  yellow = "#FAE3B0",
  purple = "#d0a9e5",
  teal = "#B5E8E0",
  orange = "#F8BD96",
  cyan = "#00FFEF",
  lavender = "#FF0069",
}

local base16 = {
  base00 = "#1E1D2D", -- bg
  base05 = "#ffffff", -- fg
  base08 = "#FF0069", -- red
  base09 = "#FF9853", -- orange
  base0A = "#FFDA0B", -- yellow
  base0B = "#47FF9C", -- green
  base0C = "#00FFEF", -- cyan
  base0D = "#89B4FA", -- blue
  base0E = "#FF0069", -- purple
}

function M.setup(opts)
    opts = opts or {}
    local transparent = opts.transparent or false
    local vcmd = vim.cmd
    vcmd("highlight clear")
    vim.o.termguicolors = true
    vim.g.colors_name = "mytheme"
    -- Main editor colors
    local bg = transparent and "NONE" or base16.base00
    vcmd("highlight Normal guifg=" .. base16.base05 .. " guibg=" .. bg)
    vcmd("highlight NormalFloat guifg=" .. base16.base05 .. " guibg=" .. bg)
    vcmd("highlight SignColumn guibg=" .. bg)
    vcmd("highlight CursorLine guibg=" .. colors.one_bg)
    vcmd("highlight LineNr guifg=" .. colors.grey)
    vcmd("highlight Visual guibg=" .. colors.one_bg2)
    -- Syntax colors
    vcmd("highlight Comment guifg=" .. colors.grey_fg)
    vcmd("highlight String guifg=" .. base16.base0B)
    vcmd("highlight Function guifg=" .. base16.base0D)
    vcmd("highlight Keyword guifg=" .. base16.base0E)
    vcmd("highlight Number guifg=" .. base16.base09)
    vcmd("highlight Type guifg=" .. base16.base0A)
    -- Your custom highlights
    vcmd("highlight @variable guifg=" .. colors.lavender)
    vcmd("highlight @property guifg=" .. colors.teal)
    vcmd("highlight @variable.builtin guifg=" .. colors.red)

    -- Bufferline (akinsho tabs) transparency
    if transparent then
	vcmd("highlight BufferLineFill guibg=NONE")
	vcmd("highlight BufferLineBackground guibg=NONE")
	vcmd("highlight BufferLineTab guibg=NONE")
	vcmd("highlight BufferLineTabSelected guibg=NONE")
	vcmd("highlight BufferLineTabClose guibg=NONE")
	vcmd("highlight BufferLineIndicatorSelected guibg=NONE")
	vcmd("highlight BufferLineSeparator guibg=NONE")
	vcmd("highlight BufferLineSeparatorSelected guibg=NONE")
	vcmd("highlight BufferLineSeparatorVisible guibg=NONE")
	vcmd("highlight BufferLineBuffer guibg=NONE")
	vcmd("highlight BufferLineBufferSelected guibg=NONE")
	vcmd("highlight BufferLineBufferVisible guibg=NONE")
    end
end

return M
