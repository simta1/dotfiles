vim.cmd([[
if !exists('*GenerateCinCodeRange')
	function! GenerateCinCodeRange(startLine, endLine)
		let l:cin_line = ""
		for i in range(a:startLine, a:endLine)
			let l:line = getline(i)
			let l:indent = matchstr(l:line, '^\s*')
			let l:match = matchlist(l:line, '\(int\|float\|double\|string\|char\|bool\|ll\|ld\|ui\|ull\)\s\+\(.\+\);')
			if len(l:match) >= 2
				let l:variables = split(l:match[2], '\s*,\s*')
				if l:cin_line == ""
					let l:cin_line = l:indent . "cin >> " . join(l:variables, " >> ")
				else
					let l:cin_line .= " >> " . join(l:variables, " >> ")
				endif
			endif
		endfor
		if l:cin_line != ""
			let l:cin_line .= ";"
			call append(a:endLine, l:cin_line)
			call cursor(a:endLine + 1, len(l:cin_line))
		else
			echo "No valid variable declaration found"
		endif
	endfunction
endif
]])

-- FileType 때 버퍼 한정으로 매핑 (리더키/버퍼 준비 완료 시점)
local grp = vim.api.nvim_create_augroup("CppCinMaps", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = grp,
	pattern = { "cpp", "c", "cxx", "cc", "hpp", "hh", "h" },
	callback = function()
		vim.cmd([[
			xnoremap <buffer> <leader>in :<C-u>call GenerateCinCodeRange(line("'<"), line("'>"))<CR>
			nnoremap <buffer> <leader>in :call GenerateCinCodeRange(line('.'), line('.'))<CR>
		]])
	end,
})
