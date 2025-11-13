return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	opts = {
		sections = {
			lualine_c = {
				{ "filename", path = 1, symbols = { modified = " [+]", readonly = " [-]" } },
			},
		},
	},
}
