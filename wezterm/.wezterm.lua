local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.window_background_opacity = 0.5 -- 배경 불투명도

config.enable_tab_bar = false

config.window_padding = {
  left   = '10px',
  right  = '10px',
  top    = '10px',
  bottom = '10px',
}

config.hide_mouse_cursor_when_typing = false

config.enable_tab_bar = false

-- config.color_scheme = 'nord'
config.color_scheme = 'Dracula'

config.font_size = 13.0
config.cell_width = 0.9
config.line_height = 1.05

config.force_reverse_video_cursor = true -- 테마에 따라 배경 반전되는 거 허용
config.colors = {
    cursor_fg = "#ffffff", -- 커서 안의 글씨 (흰색)
    cursor_bg = "#000000", -- 커서 배경 (검정색)
    split = "#FF79C6", -- multiplexing 경계선 색상
}

config.inactive_pane_hsb = { -- 비활성 pane
    saturation = 0.5, -- 색깔 얼마나 유지할지
    brightness = 0.2, -- 밝기
}

 local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")
 sessions.apply_to_config(config) -- optional, this adds default keybindings

local act = wezterm.action

config.leader = { mods = "ALT", key = "w", timeout_milliseconds = 2000 }

config.keys   = {
    -- -- wezterm sessions
    -- { key = 's', mods = 'ALT', action = act({ EmitEvent = "save_session" }), },
    -- { key = 'l', mods = 'ALT', action = act({ EmitEvent = "load_session" }), },
    -- { key = 'r', mods = 'ALT', action = act({ EmitEvent = "restore_session" }), },
    -- { key = 'd', mods = 'CTRL|SHIFT', action = act({ EmitEvent = "delete_session" }), },
    -- { key = 'e', mods = 'CTRL|SHIFT', action = act({ EmitEvent = "edit_session" }), },
    --
    -- -- Rename current workspace
    -- { key = '$', mods = 'CTRL|SHIFT', action = act.PromptInputLine {
    --     description = 'Enter new workspace name',
    --     action = wezterm.action_callback(
    --         function(window, pane, line)
    --             if line then
    --                 wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
    --             end
    --         end), }, },
    --
    -- -- Prompt for a name to use for a new workspace and switch to it.
    -- { key = 'w', mods = 'CTRL|SHIFT', action = act.PromptInputLine {
    --     description = wezterm.format {
    --         { Attribute = { Intensity = 'Bold' } },
    --         { Foreground = { AnsiColor = 'Fuchsia' } },
    --         { Text = 'Enter name for new workspace' },
    --     },
    --     action = wezterm.action_callback(function(window, pane, line)
    --         -- line will be `nil` if they hit escape without entering anything
    --         -- An empty string if they just hit enter
    --         -- Or the actual line of text they wrote
    --         if line then
    --             window:perform_action( act.SwitchToWorkspace { name = line, }, pane)
    --         end
    --     end), }, },

    -- Ctrl + / → ⎘ (U+2398)
    { mods = "CTRL", key = "/", action = act.SendString("\u{2398}") },
	{ mods = "CTRL", key = "Backspace", action = act.SendString("\x08") },

    -- Ctrl+Tab / Ctrl+Shift+Tab을 PTY로 그대로 전달
    { key = "Tab", mods = "CTRL",       action = act.SendKey { key = "Tab", mods = "CTRL" } },
    { key = "Tab", mods = "CTRL|SHIFT", action = act.SendKey { key = "Tab", mods = "CTRL|SHIFT" } },

    -- multiplexing
    { mods = 'ALT', key = 'f', action = wezterm.action.TogglePaneZoomState, },

    { mods = "LEADER", key = "'", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { mods = "LEADER", key = ";", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { mods = "LEADER", key = "u", action = act.CloseCurrentPane { confirm = false } },
    { mods = "LEADER", key = "q", action = act.CloseCurrentPane { confirm = false } },
    { mods = "LEADER", key = "LeftArrow",  action = act.ActivatePaneDirection "Left"  },
    { mods = "LEADER", key = "DownArrow",  action = act.ActivatePaneDirection "Down"  },
    { mods = "LEADER", key = "UpArrow",    action = act.ActivatePaneDirection "Up"    },
    { mods = "LEADER", key = "RightArrow", action = act.ActivatePaneDirection "Right" },
    { mods = "LEADER", key = "h", action = act.ActivatePaneDirection "Left"  },
    { mods = "LEADER", key = "j", action = act.ActivatePaneDirection "Down"  },
    { mods = "LEADER", key = "k", action = act.ActivatePaneDirection "Up"    },
    { mods = "LEADER", key = "l", action = act.ActivatePaneDirection "Right" },
    { mods = 'LEADER', key = 'o', action = act.RotatePanes "Clockwise" },
    { mods = 'LEADER', key = 'i', action = act.RotatePanes "CounterClockwise" },
    { mods = 'LEADER', key = 'Tab', action = act { PaneSelect = { alphabet = "0123456789" } } },
    { mods = 'LEADER', key = '[', action = act.ActivateCopyMode },
    { mods = 'LEADER', key = ' ', action = act.PaneSelect { mode = "SwapWithActive" } },
    { mods = 'LEADER', key = 'a', action = act.ActivateKeyTable { name = 'activate_pane', one_shot = false} },
    { mods = 'LEADER', key = 'r', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { mods = 'LEADER', key = 'c', action = act.ActivateKeyTable { name = 'rotate_pane', one_shot = false } },
    { mods = "LEADER", key = "n", action = act.ActivateKeyTable { name = "new_split", one_shot = true } },
    --
    { mods = "LEADER|ALT", key = "'", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { mods = "LEADER|ALT", key = ";", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { mods = "LEADER|ALT", key = "u", action = act.CloseCurrentPane { confirm = false } },
    { mods = "LEADER|ALT", key = "q", action = act.CloseCurrentPane { confirm = false } },
    { mods = "LEADER|ALT", key = "LeftArrow",  action = act.ActivatePaneDirection "Left"  },
    { mods = "LEADER|ALT", key = "DownArrow",  action = act.ActivatePaneDirection "Down"  },
    { mods = "LEADER|ALT", key = "UpArrow",    action = act.ActivatePaneDirection "Up"    },
    { mods = "LEADER|ALT", key = "RightArrow", action = act.ActivatePaneDirection "Right" },
    { mods = "LEADER|ALT", key = "h", action = act.ActivatePaneDirection "Left"  },
    { mods = "LEADER|ALT", key = "j", action = act.ActivatePaneDirection "Down"  },
    { mods = "LEADER|ALT", key = "k", action = act.ActivatePaneDirection "Up"    },
    { mods = "LEADER|ALT", key = "l", action = act.ActivatePaneDirection "Right" },
    { mods = 'LEADER|ALT', key = 'o', action = act.RotatePanes "Clockwise" },
    { mods = 'LEADER|ALT', key = 'i', action = act.RotatePanes "CounterClockwise" },
    { mods = 'LEADER|ALT', key = 'Tab', action = act { PaneSelect = { alphabet = "0123456789" } } },
    { mods = 'LEADER|ALT', key = '[', action = act.ActivateCopyMode },
    { mods = 'LEADER|ALT', key = ' ', action = act.PaneSelect { mode = "SwapWithActive" } },
    { mods = 'LEADER|ALT', key = 'a', action = act.ActivateKeyTable { name = 'activate_pane', one_shot = false} },
    { mods = 'LEADER|ALT', key = 'r', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { mods = 'LEADER|ALT', key = 'c', action = act.ActivateKeyTable { name = 'rotate_pane', one_shot = false } },
    { mods = "LEADER|ALT", key = "n", action = act.ActivateKeyTable { name = "new_split", one_shot = true } },
}

local default_keys = wezterm.gui.default_key_tables()
local function extend_keys(base, extra)
	local t = {}
	for _, v in ipairs(base) do table.insert(t, v) end
	for _, v in ipairs(extra) do table.insert(t, v) end
	return t
end

local function close_copy_mode()
    return act.Multiple({
        act.CopyMode('ClearSelectionMode'),
        act.CopyMode('ClearPattern'),
        act.CopyMode('Close'),
    })
end
local function next_match(int)
    local m = act.CopyMode('NextMatch')
    if int == -1 then
        m = act.CopyMode('PriorMatch')
    end
    return act.Multiple({ m, act.CopyMode('ClearSelectionMode') })
end

config.key_tables = {
	copy_mode = extend_keys(default_keys.copy_mode or {}, {
		{ key = 'c', mods = 'CTRL', action = close_copy_mode() },
		{ key = 'q', mods = 'NONE', action = close_copy_mode() },
		{ key = 'Escape', mods = 'NONE', action = close_copy_mode() },
		{ key = '/', mods = 'NONE', action = act.Multiple({
			act.CopyMode('ClearPattern'),
			act.Search({ CaseInSensitiveString = '' }),
		}), },
		{ key = 'n', mods = 'NONE', action = next_match(1) },
		{ key = 'N', mods = 'NONE', action = next_match(-1) },
	}),
	search_mode = extend_keys(default_keys.search_mode or {}, {
		{ key = 'Escape', mods = 'NONE', action = act.CopyMode('Close') },
		{ key = 'Enter',  mods = 'NONE', action = act.ActivateCopyMode },
	}),
    activate_pane = {
        { key = 'LeftArrow',  action = act.ActivatePaneDirection 'Left'  },
        { key = 'DownArrow',  action = act.ActivatePaneDirection 'Down'  },
        { key = 'UpArrow',    action = act.ActivatePaneDirection 'Up'    },
        { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
        { key = 'h',          action = act.ActivatePaneDirection 'Left'  },
        { key = 'j',          action = act.ActivatePaneDirection 'Down'  },
        { key = 'k',          action = act.ActivatePaneDirection 'Up'    },
        { key = 'l',          action = act.ActivatePaneDirection 'Right' },
        { key = 'Escape',     action = 'PopKeyTable' },
        { mods = 'ALT', key = 'LeftArrow',  action = act.ActivatePaneDirection 'Left'  },
        { mods = 'ALT', key = 'DownArrow',  action = act.ActivatePaneDirection 'Down'  },
        { mods = 'ALT', key = 'UpArrow',    action = act.ActivatePaneDirection 'Up'    },
        { mods = 'ALT', key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
        { mods = 'ALT', key = 'h',          action = act.ActivatePaneDirection 'Left'  },
        { mods = 'ALT', key = 'j',          action = act.ActivatePaneDirection 'Down'  },
        { mods = 'ALT', key = 'k',          action = act.ActivatePaneDirection 'Up'    },
        { mods = 'ALT', key = 'l',          action = act.ActivatePaneDirection 'Right' },
        { mods = 'ALT', key = 'Escape',     action = 'PopKeyTable' },
    },
    resize_pane = {
        { key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left',  1 } },
        { key = 'DownArrow',  action = act.AdjustPaneSize { 'Down',  1 } },
        { key = 'UpArrow',    action = act.AdjustPaneSize { 'Up',    1 } },
        { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'h',          action = act.AdjustPaneSize { 'Left',  1 } },
        { key = 'j',          action = act.AdjustPaneSize { 'Down',  1 } },
        { key = 'k',          action = act.AdjustPaneSize { 'Up',    1 } },
        { key = 'l',          action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'Escape',     action = 'PopKeyTable' },
        { mods = 'ALT', key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left',  1 } },
        { mods = 'ALT', key = 'DownArrow',  action = act.AdjustPaneSize { 'Down',  1 } },
        { mods = 'ALT', key = 'UpArrow',    action = act.AdjustPaneSize { 'Up',    1 } },
        { mods = 'ALT', key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
        { mods = 'ALT', key = 'h',          action = act.AdjustPaneSize { 'Left',  1 } },
        { mods = 'ALT', key = 'j',          action = act.AdjustPaneSize { 'Down',  1 } },
        { mods = 'ALT', key = 'k',          action = act.AdjustPaneSize { 'Up',    1 } },
        { mods = 'ALT', key = 'l',          action = act.AdjustPaneSize { 'Right', 1 } },
        { mods = 'ALT', key = 'Escape',     action = 'PopKeyTable' },
    },
    rotate_pane = {
        { key = 'LeftArrow',  action = act.RotatePanes "Clockwise"        },
        { key = 'DownArrow',  action = act.RotatePanes "Clockwise"        },
        { key = 'UpArrow',    action = act.RotatePanes "CounterClockwise" },
        { key = 'RightArrow', action = act.RotatePanes "CounterClockwise" },
        { key = 'h',          action = act.RotatePanes "Clockwise"        },
        { key = 'j',          action = act.RotatePanes "Clockwise"        },
        { key = 'k',          action = act.RotatePanes "CounterClockwise" },
        { key = 'l',          action = act.RotatePanes "CounterClockwise" },
        { key = 'Escape',     action = 'PopKeyTable' },
        { mods = 'ALT', key = 'LeftArrow',  action = act.RotatePanes "Clockwise"        },
        { mods = 'ALT', key = 'DownArrow',  action = act.RotatePanes "Clockwise"        },
        { mods = 'ALT', key = 'UpArrow',    action = act.RotatePanes "CounterClockwise" },
        { mods = 'ALT', key = 'RightArrow', action = act.RotatePanes "CounterClockwise" },
        { mods = 'ALT', key = 'h',          action = act.RotatePanes "Clockwise"        },
        { mods = 'ALT', key = 'j',          action = act.RotatePanes "Clockwise"        },
        { mods = 'ALT', key = 'k',          action = act.RotatePanes "CounterClockwise" },
        { mods = 'ALT', key = 'l',          action = act.RotatePanes "CounterClockwise" },
        { mods = 'ALT', key = 'Escape',     action = 'PopKeyTable' },
    },
    new_split = {
        { key = "j", action = act.SplitVertical   { domain = "CurrentPaneDomain" } },
        { key = "l", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { key = "Escape", action = "PopKeyTable" },
        { mods = 'ALT', key = "j", action = act.SplitVertical   { domain = "CurrentPaneDomain" } },
        { mods = 'ALT', key = "l", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { mods = 'ALT', key = "Escape", action = "PopKeyTable" },
    }
}

-- 수정자 붙은 Tab을 잃지 않고 보내기
config.enable_csi_u_key_encoding = true

config.use_ime = true -- 한/영 입력기 사용
config.send_composed_key_when_right_alt_is_pressed = false -- RAlt를 조합키로 보내지 않기(= 한/영 토글 막지 않기)
config.use_dead_keys = false -- 데드키 조합 비활성(충돌 예방)

return config
