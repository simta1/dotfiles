return {
	"neovim/nvim-lspconfig",
	opts = {
		inlay_hints = { enabled = false },
		servers = {
            clangd = {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--fallback-style=llvm",
                    "--extra-arg=-Wno-parentheses", 
                },
            },
			stylua = false,
		},
	},
}
