local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 10
config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Regular', stretch = 'Expanded' })

config.color_scheme = 'nordfox'

-- Show which key table is active in the status area
local function key_table_mode(window, pane)
  local name = window:active_key_table()
  if name then
    name = name .. " "
  else
    name = ""
  end
  return name
end

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
      { Foreground = { Color = "#ebcb8b" } },
      { Attribute = { Intensity= "Bold" } },
      'index',
      { 'process', padding = { left = 0, right = 0 } }
    },
    tab_inactive = { 'index', { 'process', padding = { left = 0, right = 0 } } },
    tabline_x = {
      { Attribute = { Intensity= "Bold" } },
      key_table_mode
    },
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
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 10000 }
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
    key = 'V',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    key = 'v',
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
  -- resize mode
  -- Puts wez into 'resize mode' where one can resize the active pane.
  -- Stays until mode is cancelled.
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'RESIZE',
      one_shot = false
    }
  },
  -- focus/move mode
  -- Puts wez into a mode where one can focus and move panes around.
  -- Stays until mode is cancelled.
  {
    key = 'm',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'MOVE',
      one_shot = false
    }
  }
}

config.key_tables = {
  -- Pane resizing
  RESIZE = {
    {
      key = 'h',
      action = act.AdjustPaneSize { 'Left', 1 }
    },

    {
      key = 'j',
      action = act.AdjustPaneSize { 'Down', 1 }
    },

    {
      key = 'k',
      action = act.AdjustPaneSize { 'Up', 1 }
    },

    {
      key = 'l',
      action = act.AdjustPaneSize { 'Right', 1 }
    },

    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },

  -- Pane Movement
  MOVE = {
    {
      key = 'h',
      action = act.ActivatePaneDirection 'Left',
    },

    {
      key = 'j',
      action = act.ActivatePaneDirection 'Down',
    },

    {
      key = 'k',
      action = act.ActivatePaneDirection 'Up',
    },

    {
      key = 'l',
      action = act.ActivatePaneDirection 'Right',
    },

    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  }
}

return config

