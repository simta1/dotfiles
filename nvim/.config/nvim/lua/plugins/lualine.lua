return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	opts = {
		sections = {
			lualine_c = {
				{ "filename", path = 1, symbols = { modified = " [+]", readonly = " [-]" } },
			},
		},
	},
}
