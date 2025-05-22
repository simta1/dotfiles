set runtimepath^=~/.local/share/nvim/runtime
set runtimepath+=~/.config/nvim

set ignorecase
set smartcase
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
syntax on
set mouse=a
" set clipboard=unnamedplus
" set showmatch
set termguicolors " tmux에서도 색깔 똑같이 나오게 함

call plug#begin('~/.config/nvim/plugged')
Plug 'jiangmiao/auto-pairs' " 괄호 열면 자동으로 닫는 괄호 생성
Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim' " easymotion 대용
Plug 'nvim-tree/nvim-tree.lua'
Plug 'numToStr/Comment.nvim' " gcc로 주석 추가
Plug 'psliwka/vim-smoothie'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting용 플러그인 :TSInstallInfo로 설치된 언어 확인 :TSInstall lua처럼 언어 설치 가능
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim' " nvim-lua/plenary.nvim 필요
Plug 'wakatime/vim-wakatime'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'ellisonleao/glow.nvim', { 'do': ':Glow' } " 마크다운 미리보기용인데 잘 안됨(새로운 환경에서 사용하려는 경우 GLOW 따로 설치해야 됨)

" syntax highlighting
Plug 'folke/tokyonight.nvim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'

" 게임 관련
Plug 'alec-gibson/nvim-tetris' " :Tetris 로 실행
Plug 'seandewar/nvimesweeper' " :Nvimesweeper 로 실행
Plug 'seandewar/killersheep.nvim' " :KillKillKill 로 실행
Plug 'ThePrimeagen/vim-be-good' " :VimBeGood 로 실행
Plug 'Eandrju/cellular-automaton.nvim' " :CellularAutomaton game_of_life 또는 :CellularAutomaton make_it_rain 실행 / nvim-treesitter 필요

call plug#end()

" syntax highlighting --- 휴지통
" colorscheme tokyonight " 푸른색 계열
" colorscheme gruvbox " 붉은색 계열(내취향아님)
" colorscheme dracula " 좋음
" colorscheme catppuccin " 좋음
" colorscheme solarized " background=light(내취향아님)

" syntax highlighting --- 좋은거 1 근데 다크모드임
" colorscheme onedark
" set background=dark

" syntax highlighting --- 좋은거 2 라이트모드임
colorscheme PaperColor
set background=light

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "cpp", "python", "lua", "javascript", "typescript", "rust", "go",
    "java", "bash", "html", "css", "json", "yaml", "toml", "markdown"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false
  }
}
EOF

autocmd User visual_multi_start :TSDisable highlight
autocmd User visual_multi_exit :TSEnable highlight

" comment.nvim
lua << EOF
require('Comment').setup()
EOF

" comment.nvim ctrl+/로 주석
nmap <C-_> gcc
xmap <C-_> gc

" Airline
let g:airline#extensions#tabline#enabled = 1 " 화면 상단에 열려 있는 버퍼들을 탭 형태로 표시해줌
" let g:airline_powerline_fonts = 1

" vim-smoothie
let g:smoothie_enabled = 1
let g:smoothie_speed_linear_factor = 10   " 기본값: 10 (값을 높이면 빠르게 스크롤)
let g:smoothie_speed_exponentiation_factor = 0.75 " 기본값: 0.85 (값을 높이면 감속 정도가 줄어듦)
let g:smoothie_update_interval = 8

" Surround
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap ys <Plug>Ysurround
nmap yss <Plug>Yssurround

" Hop (easymotion 대용)
lua << EOF
require'hop'.setup()
EOF

nmap <Leader>w <cmd>lua require'hop'.hint_words()<cr>
xmap <Leader>w <cmd>lua require'hop'.hint_words()<cr>

" todo-comments
lua << EOF
require("todo-comments").setup {
  highlight = {
    pattern = [[.*<(KEYWORDS)\s*:?\s*]], -- KEYWORDS 뒤에 ':' 없어도 되게 함
  },
}
EOF

" ----------------- ps 관련 (cin 입력받는 코드 자동 생성) -----------------
function! GenerateCinCodeRange(startLine, endLine)
  let l:cin_line = ""
  for i in range(a:startLine, a:endLine)
    let l:line = getline(i)
    let l:indent = matchstr(l:line, '^\s*')
    let l:match = matchlist(l:line, '\(int\|float\|double\|string\|char\|bool\|ll\|ld\|ui\|ull\)\s\+\(.\+\);')

    if len(l:match) >= 2
      let l:variables = l:match[2]
      let l:variables = split(l:variables, '\s*,\s*')

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

xnoremap <leader>in :<C-u>call GenerateCinCodeRange(line("'<"), line("'>"))<CR>
nnoremap <leader>in :call GenerateCinCodeRange(line('.'), line('.'))<CR>
" -------------------------------------------------------------------------

nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
