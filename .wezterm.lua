local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 13
config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Regular', stretch = 'Expanded' })

config.color_scheme = 'nordfox'

-- Tab bar style via tabline!
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'nord',
    tabs_enabled = true,
    section_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
    component_separators = {
      left = wezterm.nerdfonts.ple_left_half_circle_thin,
      right = wezterm.nerdfonts.ple_right_half_circle_thin,
    },
    tab_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tab_active = {
      'index',
      { 'process', padding = { left = 0, right = 0 } }
    },
    tab_inactive = { 'index', { 'process', padding = { left = 0, right = 0 } } },
    tabline_x = { '' },
    tabline_y = { 'datetime' },
    tabline_z = { 'domain' },
  }
})

-- Config options needed for tabline to look nice
tabline.apply_to_config(config)

return config

