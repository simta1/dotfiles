return {
	"windwp/windline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local windline = require('windline')
		local helper = require('windline.helpers')
		local utils = require('windline.utils')
		local sep = helper.separators
		local animation = require('wlanimation')
		local efffects = require('wlanimation.effects')
		local lsp_comps = require('windline.components.lsp')
		local git_comps = require('windline.components.git')

		local b_components = require('windline.components.basic')
		local state = _G.WindLine.state

		local hl_list = {
			Black = { 'white', 'black' },
			Inactive = { 'InactiveFg', 'InactiveBg' },
			Active = { 'ActiveFg', 'ActiveBg' },
		}
		local basic = {}

		basic.divider = { '%=', '' }
		basic.space = { ' ', '' }
		basic.line_col = { [[ %3l:%-2c ]], hl_list.Black }
		basic.progress = { [[%3p%% ]], hl_list.Black }
		basic.bg = { ' ', 'StatusLine' }
		basic.file_name_inactive = { '%f', hl_list.Inactive }
		basic.line_col_inactive = { [[ %3l:%-2c ]], hl_list.Inactive }
		basic.progress_inactive = { [[%3p%% ]], hl_list.Inactive }

		utils.change_mode_name({
			['n'] = { ' NORMAL', 'Normal' },
			['no'] = { ' O-PENDING', 'Visual' },
			['nov'] = { ' O-PENDING', 'Visual' },
			['noV'] = { ' O-PENDING', 'Visual' },
			['no'] = { ' O-PENDING', 'Visual' },
			['niI'] = { ' NORMAL', 'Normal' },
			['niR'] = { ' NORMAL', 'Normal' },
			['niV'] = { ' NORMAL', 'Normal' },
			['v'] = { ' VISUAL', 'Visual' },
			['V'] = { ' V-LINE', 'Visual' },
			[''] = { ' V-BLOCK', 'Visual' },
			['s'] = { ' SELECT', 'Visual' },
			['S'] = { ' S-LINE', 'Visual' },
			[''] = { ' S-BLOCK', 'Visual' },
			['i'] = { ' INSERT', 'Insert' },
			['ic'] = { ' INSERT', 'Insert' },
			['ix'] = { ' INSERT', 'Insert' },
			['R'] = { ' REPLACE', 'Replace' },
			['Rc'] = { ' REPLACE', 'Replace' },
			['Rv'] = { 'V-REPLACE', 'Normal' },
			['Rx'] = { ' REPLACE', 'Normal' },
			['c'] = { ' COMMAND', 'Command' },
			['cv'] = { ' COMMAND', 'Command' },
			['ce'] = { ' COMMAND', 'Command' },
			['r'] = { ' REPLACE', 'Replace' },
			['rm'] = { ' MORE', 'Normal' },
			['r?'] = { ' CONFIRM', 'Normal' },
			['!'] = { ' SHELL', 'Normal' },
			['t'] = { ' TERMINAL', 'Command' },
		})

		basic.vi_mode = {
			name = 'vi_mode',
			hl_colors = {
				Normal = { 'white', 'black' },
				Insert = { 'black', 'red' },
				Visual = { 'black', 'green' },
				Replace = { 'black', 'cyan' },
				Command = { 'black', 'yellow' },
			},
			text = function()
				return ' ' .. state.mode[1] .. ' '
			end,
			hl = function()
				return state.mode[2]
			end,
		}

		basic.vi_mode_sep = {
			name = 'vi_mode_sep',
			hl_colors = {
				Normal = { 'black', 'white' },
				Insert = { 'red', 'white' },
				Visual = { 'green', 'white' },
				Replace = { 'cyan', 'white' },
				Command = { 'yellow', 'white' },
			},
			text = function()
				return sep.right_rounded
			end,
			hl = function()
				return state.mode[2]
			end,
		}

		-- basic.file_name = {
		-- 	text = function()
		-- 		local name = vim.fn.expand('%:p:t')
		-- 		if name == '' then
		-- 			name = '[No Name]'
		-- 		end
		-- 		return name .. ' '
		-- 	end,
		-- 	hl_colors = { 'FilenameFg', 'FilenameBg' },
		-- }

		basic.file = {
			name = 'file',
			hl_colors = {
				default = hl_list.White,
			},
			text = function()
				return {
					{b_components.cache_file_icon({ default = '' }), 'default'},
					{ ' ', 'default' },
					{ b_components.cache_file_name('[No Name]', 'unique') },
					{ b_components.file_modified('[+] ')},
					{ b_components.cache_file_size()},
				}
			end,
		}

		basic.lsp_diagnos = {
			name = 'diagnostic',
			hl_colors = {
				red = { 'red', 'black' },
				yellow = { 'yellow', 'black' },
				blue = { 'blue', 'black' },
			},
			width = breakpoint_width,
			text = function(bufnr)
				if lsp_comps.check_lsp(bufnr) then
					return {
						{ lsp_comps.lsp_error({ format = '  %s', show_zero = true }), 'red' },
						{ lsp_comps.lsp_warning({ format = '  %s', show_zero = true }), 'yellow' },
						{ lsp_comps.lsp_hint({ format = '  %s', show_zero = true }), 'blue' },
					}
				end
				return ''
			end,
		}

		local status_color = ''
		local change_color = function()
			local anim_colors = {
				'#90CAF9',
				'#64B5F6',
				'#42A5F5',
				'#2196F3',
				'#1E88E5',
				'#1976D2',
				'#1565C0',
				'#0D47A1',
			}
			if status_color == 'blue' then
				anim_colors = {
					'#F9FBE7',
					'#F0F4C3',
					'#E6EE9C',
					'#DCE775',
					'#D4E157',
					'#CDDC39',
					'#C0CA33',
					'#AFB42B',
				}
				status_color = 'yellow'
			else
				status_color = 'blue'
			end

			animation.stop_all()
			animation.animation({
				data = {
					{ 'waveleft1', efffects.list_color(anim_colors, 6) },
					{ 'waveleft2', efffects.list_color(anim_colors, 5) },
					{ 'waveleft3', efffects.list_color(anim_colors, 4) },
					{ 'waveleft4', efffects.list_color(anim_colors, 3) },
					{ 'waveleft5', efffects.list_color(anim_colors, 2) },
				},
				timeout = 100,
				delay = 200,
				interval = 150,
			})

			animation.animation({
				data = {
					{ 'waveright1', efffects.list_color(anim_colors, 2) },
					{ 'waveright2', efffects.list_color(anim_colors, 3) },
					{ 'waveright3', efffects.list_color(anim_colors, 4) },
					{ 'waveright4', efffects.list_color(anim_colors, 5) },
					{ 'waveright5', efffects.list_color(anim_colors, 6) },
				},
				timeout = 100,
				delay = 200,
				interval = 150,
			})
		end

		local wave_left = {
			text = function()
				return {
					{ sep.right_rounded .. ' ', { 'black', 'waveleft1' } },
					{ sep.right_rounded .. ' ', { 'waveleft1', 'waveleft2' } },
					{ sep.right_rounded .. ' ', { 'waveleft2', 'waveleft3' } },
					{ sep.right_rounded .. ' ', { 'waveleft3', 'waveleft4' } },
					{ sep.right_rounded .. ' ', { 'waveleft4', 'waveleft5' } },
					{ sep.right_rounded .. ' ', { 'waveleft5', 'wavedefault' } },
				}
			end,
			click = change_color,
		}

		local wave_right = {
			text = function()
				return {
					{ ' ' .. sep.left_rounded, { 'waveright1', 'wavedefault' } },
					{ ' ' .. sep.left_rounded, { 'waveright2', 'waveright1' } },
					{ ' ' .. sep.left_rounded, { 'waveright3', 'waveright2' } },
					{ ' ' .. sep.left_rounded, { 'waveright4', 'waveright3' } },
					{ ' ' .. sep.left_rounded, { 'waveright5', 'waveright4' } },
					{ ' ' .. sep.left_rounded, { 'black', 'waveright5' } },
				}
			end,
			click = change_color,
		}

		basic.recording = {
			name = "recording",
			text = function()
				local rec = vim.fn.reg_recording()
				if rec ~= "" then
					return { { " recording @" .. rec .. " ", { "yellow", "black" } } }
				end
				return ""
			end,
		}

		local default = {
			filetypes = { 'default' },
			active = {
				basic.vi_mode,
				basic.vi_mode_sep,
				{ git_comps.git_branch(), { 'white_light', 'white'} },
				{ ' ', '' },
				{ sep.right_rounded, { 'white', 'black_light' } },
				{ ' ', '' },
				-- basic.file_name,
				basic.file,
				{ sep.right_rounded, { 'black_light', 'black' } },
				basic.lsp_diagnos,
				{ ' ', '' },
				wave_left,
				{ ' ', { 'FilenameBg', 'wavedefault' } },
				basic.divider,
				wave_right,
				basic.recording,
				basic.line_col,
				basic.progress,
			},
			inactive = {
				basic.file_name_inactive,
				basic.divider,
				basic.divider,
				basic.line_col_inactive,
				{ '', { 'white', 'InactiveBg' } },
				basic.progress_inactive,
			},
		}

		windline.setup({
			colors_name = function(colors)
				colors.FilenameFg = colors.white
				colors.FilenameBg = colors.black_light

				colors.wavedefault = colors.white_light
				colors.waveleft1 = colors.wavedefault
				colors.waveleft2 = colors.wavedefault
				colors.waveleft3 = colors.wavedefault
				colors.waveleft4 = colors.wavedefault
				colors.waveleft5 = colors.wavedefault

				colors.waveright1 = colors.wavedefault
				colors.waveright2 = colors.wavedefault
				colors.waveright3 = colors.wavedefault
				colors.waveright4 = colors.wavedefault
				colors.waveright5 = colors.wavedefault
				return colors
			end,
			statuslines = {
				default,
			},
		})

		vim.defer_fn(function()
			change_color()
		end, 100)
	end,
}
