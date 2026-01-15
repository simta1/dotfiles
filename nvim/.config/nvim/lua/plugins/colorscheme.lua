return {
	"Mofiqul/dracula.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("dracula")
		vim.o.background = "dark"

		vim.cmd([[
			" highlight comment       guifg=#ffb86c ctermfg=215 gui=italic
			" highlight normal        guibg=none ctermbg=none
			" highlight normalnc      guibg=none ctermbg=none
			" highlight normalfloat   guibg=none ctermbg=none
			" highlight floatborder   guibg=none ctermbg=none
			" highlight signcolumn    guibg=none ctermbg=none
			" highlight linenr        guibg=none ctermbg=none
			" highlight endofbuffer   guibg=none ctermbg=none
			" highlight search        gui=underline,bold guibg=none guifg=#eeff41 cterm=underline ctermfg=190
			" highlight incsearch     gui=underline,bold guibg=none guifg=#00ffc3 cterm=underline ctermfg=49
			" highlight cursearch     gui=underline,bold guibg=none guifg=#00ffc3 cterm=underline ctermfg=49
			" highlight NonText       guifg=#6c7086 guibg=NONE
			highlight WinSeparator  guifg=#89b4fa guibg=NONE gui=bold
		]])
	end,
}
