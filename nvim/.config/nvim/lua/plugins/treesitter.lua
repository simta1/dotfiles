return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"c", "cpp", "rust", "bash", "awk",
			"make", "python", "lua", "html", "css",
			"javascript", "typescript", "tsx", "java",
			"go", "php", "json", "yaml", "toml", "xml",
			"markdown", "markdown_inline", "sql",
		},
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		indent = { enable = true },
	},
}
