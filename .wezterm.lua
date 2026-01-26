local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 10
config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Regular', stretch = 'Expanded' })

config.color_scheme = 'nordfox'

-- Tab bar style via tabline!
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'nordfox',
    tabs_enabled = true,
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tab_active = {
      'index',
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
    tabline_x = { ' ' },
    tabline_y = { 'datetime' },
    tabline_z = { 'domain' },
  }
})

-- Config options needed for tabline to look nice
tabline.apply_to_config(config)
config.window_decorations = 'TITLE | RESIZE'

return config

