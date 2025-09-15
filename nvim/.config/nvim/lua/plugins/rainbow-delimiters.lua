return {
	"HiPhish/rainbow-delimiters.nvim",
	config = function()
		local rainbow_delimiters = require("rainbow-delimiters")

		vim.g.rainbow_delimiters = {
			strategy = {
				[''] = rainbow_delimiters.strategy['global'],
				vim = rainbow_delimiters.strategy['local'],
			},
			query = {
				[''] = 'rainbow-delimiters',
				lua = 'rainbow-blocks',
			},
			highlight = {
				"RainbowDelimiterViolet",
				"RainbowDelimiterGreen",
				"RainbowDelimiterYellow",
				"RainbowDelimiterOrange",
				"RainbowDelimiterPink",
				"RainbowDelimiterCyan",
				"RainbowDelimiterBlue",
				-- "RainbowDelimiterForeground1",
				-- "RainbowDelimiterForeground2",
				-- "RainbowDelimiterForeground3",
				-- "RainbowDelimiterForeground4",
				-- "RainbowDelimiterForeground5",
				-- "RainbowDelimiterForeground6",
			}
		}
		vim.cmd([[
			highlight RainbowDelimiterForeground1 guifg=#B48EAD
			highlight RainbowDelimiterForeground2 guifg=#A3BE8C
			highlight RainbowDelimiterForeground3 guifg=#EBCB8B
			highlight RainbowDelimiterForeground4 guifg=#D08770
			highlight RainbowDelimiterForeground5 guifg=#BF616A
			highlight RainbowDelimiterForeground6 guifg=#abb2c0
			highlight RainbowDelimiterViolet guifg=#bd93f9
			highlight RainbowDelimiterGreen  guifg=#50fa7b
			highlight RainbowDelimiterYellow guifg=#f1fa8c
			highlight RainbowDelimiterOrange guifg=#ffb86c
			highlight RainbowDelimiterPink   guifg=#ff79c6
			highlight RainbowDelimiterCyan   guifg=#8be9fd
			highlight RainbowDelimiterBlue   guifg=#61afef
		]])
	end,
}
