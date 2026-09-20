-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font_size = 14.0

config.keys = {
  -- This will create a new split and run your default program inside it
  {
    key = 'o',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- This will create a new split and run your default program inside it
  {
    key = 'e',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Move to the pane on the left
  {
    key="LeftArrow", 
    mods="ALT", 
    action=wezterm.action.ActivatePaneDirection("Left")
  },
  -- Move to the pane on the right
  {
    key="RightArrow", 
    mods="ALT", 
    action=wezterm.action.ActivatePaneDirection("Right")
  },
  -- Move to the pane above
  {
    key="UpArrow", 
    mods="ALT", 
    action=wezterm.action.ActivatePaneDirection("Up")
  },
  -- Move to the pane below
  {
    key="DownArrow", 
    mods="ALT", 
    action=wezterm.action.ActivatePaneDirection("Down")
  },
  -- Close current pane
  {
    key="w", 
    mods="ALT", 
    action=wezterm.action.CloseCurrentPane{confirm=true}
  },
  -- Open a new Tab
  {
    key="t",
    mods="CTRL|SHIFT",
    action=wezterm.action.SpawnTab("DefaultDomain")
  },
  -- Switch to the next tab
  {
    key="RightArrow",
    mods="SHIFT",
    action=wezterm.action.ActivateTabRelative(1)
  },
  -- Switch to the previous tab
  {
    key="LeftArrow",
    mods="SHIFT",
    action=wezterm.action.ActivateTabRelative(-1)
  },
  -- Copy to clipboard
  {
    key="C", 
    mods='CTRL|SHIFT', 
    action=wezterm.action.CopyTo 'Clipboard'
  },
  -- Paste from clipboard
  {
    key="V", 
    mods='CTRL|SHIFT', 
    action=wezterm.action.PasteFrom 'Clipboard'
  },
}

-- and finally, return the configuration to wezterm
return config


