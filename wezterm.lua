local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.default_prog = {"C:\\Program Files\\Git\\bin\\bash.exe"}


config.color_scheme = 'Kasugano (terminal.sexy)'

return config
