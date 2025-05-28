local wezterm = require 'wezterm'
-- local catppuccin = require "catppuccin"

local config = wezterm.config_builder()
-- wezterm.add_to_config(catppuccin)
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = "Medium" })
config.window_background_opacity = 0.93
config.enable_tab_bar = false
config.color_scheme = 'Catppuccin Mocha'
config.colors = {
	foreground = "#FFFFFF",
	background = "#0D0D13",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}


return config
