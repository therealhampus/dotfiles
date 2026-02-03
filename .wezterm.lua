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
config.window_padding = {
  left = 10,
  right = 10,
  top = 5,
  bottom = 5,
}

-- Configure keybindings (mainly to have multiplexing behaviour)
local act = wezterm.action
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Turn off default hide action (CMD-m). Keep uassigned for now.
  {
    key = 'm',
    mods = 'CMD',
    action = act.DisableDefaultAssignment,
  },
  -- Multiplexer bindings
  -- Pane Modification
  {
    key = 's',
    mods = 'LEADER',
    action = act.PaneSelect {
      mode = 'SwapWithActive'
    },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    key = '|',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
  },
  -- Pane Movement
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Right',
  },
}

return config

