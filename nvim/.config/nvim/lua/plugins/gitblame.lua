return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = true,
		message_template = " • <summary> • <author> • <date>",
		date_format = "%Y-%m-%d %H:%M",
		delay = 500,
		ignore_filetype = { "markdown", "help", "txt" },
	},
	config = function(_, opts)
		require("gitblame").setup(opts)
		-- vim.api.nvim_set_hl(0, "GitBlameColor", { fg = "#b5bbc7", bg = "#222436", italic = false })
		vim.api.nvim_set_hl(0, "GitBlameColor", { bg = "#2F334D", italic = false })
        vim.g.gitblame_highlight_group = "GitBlameColor"
	end,
}
