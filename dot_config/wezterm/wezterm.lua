---@diagnostic disable: unused-local
local wezterm = require("wezterm")
local act = wezterm.action
local mod = "SHIFT|CTRL"

local function font(opts)
	return wezterm.font_with_fallback({
		opts,
		"Symbols Nerd Font Mono",
	})
end

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return {
		{ Text = " " .. tab.active_pane.title .. " " },
	}
end)

local function make_mouse_binding(dir, streak, button, mods, action)
	return {
		event = { [dir] = { streak = streak, button = button } },
		mods = mods,
		action = action,
	}
end

return {
  -- stylua: ignore
	mouse_bindings = {
		make_mouse_binding( "Up", 1, "Left", "NONE", wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection")),
		make_mouse_binding( "Up", 1, "Left", "SHIFT", wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection")),
		make_mouse_binding("Up", 1, "Left", "ALT", wezterm.action.CompleteSelection("ClipboardAndPrimarySelection")),
		make_mouse_binding( "Up", 1, "Left", "SHIFT|ALT", wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection")),
		make_mouse_binding("Up", 2, "Left", "NONE", wezterm.action.CompleteSelection("ClipboardAndPrimarySelection")),
		make_mouse_binding("Up", 3, "Left", "NONE", wezterm.action.CompleteSelection("ClipboardAndPrimarySelection")),
	},
	-- term = "wezterm",
	font_size = 12.5,
	font = font("SauceCodePro Nerd Font Mono"),
	-- font_rules = {
	-- 	{
	-- 		italic = true,
	-- 		intensity = "Normal",
	-- 		font = font({
	-- 			family = "Victor Mono",
	-- 			style = "Italic",
	-- 		}),
	-- 	},
	-- 	{
	-- 		italic = true,
	-- 		intensity = "Half",
	-- 		font = font({
	-- 			family = "Victor Mono",
	-- 			weight = "DemiBold",
	-- 			style = "Italic",
	-- 		}),
	-- 	},
	-- 	{
	-- 		italic = true,
	-- 		intensity = "Bold",
	-- 		font = font({
	-- 			family = "Victor Mono",
	-- 			weight = "Bold",
	-- 			style = "Italic",
	-- 		}),
	-- 	},
	-- },
	color_scheme_dirs = { "/home/jrn23/.config/wezterm/colors" },
	color_scheme = "tokyonight_storm",
	use_fancy_tab_bar = true,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	-- window_decorations = "NONE",
	window_frame = {
		-- The font used in the tab bar.
		-- Roboto Bold is the default; this font is bundled
		-- with wezterm.
		-- Whatever font is selected here, it will have the
		-- main font setting appended to it to pick up any
		-- fallback fonts you may have used there.
		font = font({ family = "SauceCodePro Nerd Font Mono", weight = "Bold" }),

		-- The size of the font in the tab bar.
		-- Default to 10. on Windows but 12.0 on other systems
		font_size = 11.5,

		-- The overall background color of the tab bar when
		-- the window is focused
		active_titlebar_bg = "#12131d",

		-- The overall background color of the tab bar when
		-- the window is not focused
		inactive_titlebar_bg = "#1e2030",
		border_left_width = "0.2cell",
		border_right_width = "0.0cell",
		border_bottom_height = "0.0cell",
		border_top_height = "0.00cell",
	},
	window_padding = {
		left = 0,
		right = 0,
		top = "5px",
		bottom = "0px",
	},
	-- disable_default_key_bindings = true,
	keys = {
		{ mods = "CTRL", key = "UpArrow", action = act.ActivatePaneDirection("Up") },
		{ mods = "CTRL", key = "DownArrow", action = act.ActivatePaneDirection("Down") },
		{ mods = "CTRL", key = "RightArrow", action = act.ActivatePaneDirection("Right") },
		{ mods = "CTRL", key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
		{ mods = mod, key = "t", action = act.SpawnTab("CurrentPaneDomain") },
		{ mods = mod, key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ mods = mod, key = "_", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ mods = mod, key = ">", action = act.MoveTabRelative(1) },
		{ mods = mod, key = "<", action = act.MoveTabRelative(-1) },
		{ mods = mod, key = "M", action = act.TogglePaneZoomState },
		{ mods = mod, key = "p", action = act.PaneSelect({ alphabet = "", mode = "Activate" }) },
		{ mods = mod, key = "C", action = act.CopyTo("ClipboardAndPrimarySelection") },
		{ mods = mod, key = "l", action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ mods = mod, key = "h", action = wezterm.action({ ActivateTabRelative = -1 }) },
		{ key = "C", mods = "CTRL", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
		{ mods = mod, key = "d", action = wezterm.action.ShowDebugOverlay },
	},
	bold_brightens_ansi_colors = true,
	window_background_opacity = 1.0,
	cell_width = 1.0,
	scrollback_lines = 10000,
	hyperlink_rules = {
		-- Linkify things that look like URLs and the host has a TLD name.
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},

		-- linkify email addresses
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = "mailto:$0",
		},

		-- file:// URI
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\bfile://\S*\b]],
			format = "$0",
		},

		-- Linkify things that look like URLs with numeric addresses as hosts.
		-- E.g. http://127.0.0.1:8000 for a local development server,
		-- or http://192.168.1.1 for the web interface of many routers.
		{
			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
			format = "$0",
		},

		-- Make username/project paths clickable. This implies paths like the following are for GitHub.
		-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
		-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
		{
			regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
			format = "https://www.github.com/$1/$3",
		},
	},
}
