-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- This is where you actually apply your config choices
config.default_cursor_style = 'BlinkingBar'
config.font = wezterm.font_with_fallback {'JetBrains Mono', 'Fira Code'}
config.warn_about_missing_glyphs = false
config.font_size = 13

-- config.default_domain = 'WSL:Ubuntu'
if os.getenv("OS") == "Windows_NT" then
  config.default_prog = {'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe'}
end
config.color_scheme = 'MaterialDarker'
config.keys = {
  -- paste from clipboard
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  -- paste from primary selection
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' }
}

-- and finally, return the configuration to wezterm
return config

