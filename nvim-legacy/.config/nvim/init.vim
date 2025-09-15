set runtimepath^=~/.local/share/nvim/runtime
set runtimepath+=~/.config/nvim

set ignorecase
set smartcase
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors
syntax on
set mouse=a
" set clipboard=unnamedplus " 이거 하면 기본적으로 뭘하든 +레지스터로 들어감 최악임
" set showmatch

call plug#begin('~/.config/nvim/plugged')
Plug 'jiangmiao/auto-pairs' " 괄호 열면 자동으로 닫는 괄호 생성
Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim' " easymotion 대용
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
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
Plug 'lewis6991/gitsigns.nvim' " git 변경사항 표시
Plug 'romainl/vim-cool' " :nohlsearch 자동으로 해줌
Plug 'monaqa/dial.nvim'

" path intellisense
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'onsails/lspkind-nvim'   " 아이콘 예쁘게
Plug 'neovim/nvim-lspconfig'   " LSP 설정

" 색깔 미리보기
Plug 'brenoprata10/nvim-highlight-colors'

" syntax highlighting
Plug 'folke/tokyonight.nvim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Mofiqul/vscode.nvim'

" 게임 관련
Plug 'alec-gibson/nvim-tetris' " :Tetris 로 실행
Plug 'seandewar/nvimesweeper' " :Nvimesweeper 로 실행
Plug 'seandewar/killersheep.nvim' " :KillKillKill 로 실행
Plug 'ThePrimeagen/vim-be-good' " :VimBeGood 로 실행
Plug 'Eandrju/cellular-automaton.nvim' " :CellularAutomaton game_of_life 또는 :CellularAutomaton make_it_rain 실행 / nvim-treesitter 필요
call plug#end()

augroup NvimHighlightColors
  autocmd!
  autocmd ColorScheme * lua require('nvim-highlight-colors').turnOn()
augroup END

if exists('g:vscode') && g:vscode " vscode 내에서는 nvim상태줄 숨김
    augroup VSCodeStatusline
        autocmd!
        autocmd VimEnter * set laststatus=0
    augroup END
else " 그냥 nvim 사용할 땐 상태줄 표시
    set laststatus=2
endif

lua << EOF
local augend = require("dial.augend")
require("dial.config").augends:register_group{
    default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"], -- 날짜
        augend.constant.alias.bool, -- true <-> false (소문자만)
        augend.constant.new{ elements = {"TRUE", "FALSE"}, word = true, cyclic = true, },
        augend.constant.new{ elements = {"yes", "no"}, word = true, cyclic = true, },
        augend.constant.new{ elements = {"YES", "NO"}, word = true, cyclic = true, },
    }
}
EOF

nmap <C-a> <Plug>(dial-increment)
vmap <C-a> <Plug>(dial-increment)
nmap <C-x> <Plug>(dial-decrement)
vmap <C-x> <Plug>(dial-decrement)

" cmp 설정
lua << EOF
local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
    })
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }
})
EOF

" LSP 설정 예시 (tsserver)
lua << EOF
require('lspconfig').ts_ls.setup{}
EOF

" nvim-highlight-colors 설정 (배경에 칠하기 + Tailwind 활성화)
lua << EOF
require('nvim-highlight-colors').setup({
    render = 'background',
    enable_tailwind = true,
})
EOF

" colorscheme tokyonight " 푸른색 계열
" colorscheme gruvbox " 붉은색 계열(내취향아님)
" colorscheme dracula " 좋음
" colorscheme catppuccin " 좋음
" colorscheme solarized " background=light(내취향아님)
" colorscheme onedark
" colorscheme PaperColor
" colorscheme vscode
colorscheme dracula
set background=dark
highlight Comment       guifg=#ffb86c ctermfg=215 gui=italic
highlight Normal        guibg=NONE ctermbg=NONE 
highlight NormalNC      guibg=NONE ctermbg=NONE 
highlight NormalFloat   guibg=NONE ctermbg=NONE 
highlight FloatBorder   guibg=NONE ctermbg=NONE 
highlight SignColumn    guibg=NONE ctermbg=NONE 
highlight LineNr        guibg=NONE ctermbg=NONE 
highlight EndOfBuffer   guibg=NONE ctermbg=NONE 
highlight Search    gui=underline,bold guibg=NONE guifg=#eeff41 cterm=underline ctermfg=190
highlight IncSearch gui=underline,bold guibg=NONE guifg=#00ffc3 cterm=underline ctermfg=49
highlight CurSearch gui=underline,bold guibg=NONE guifg=#00ffc3 cterm=underline ctermfg=49
" highlight Search    guibg=#fffdb0 guifg=#000000 ctermbg=229 ctermfg=235
" highlight IncSearch guibg=#b5e6ff guifg=#000000 ctermbg=153 ctermfg=235
" highlight CurSearch guibg=#b5e6ff guifg=#000000 ctermbg=153 ctermfg=235

" 커서 강조
set cursorline

Plug 'lewis6991/gitsigns.nvim'
lua << EOF
  require('gitsigns').setup()
EOF

" nvim-tree 권장: netrw 끄기
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

lua << EOF
require('nvim-tree').setup({
    hijack_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd    = true,

    view = {
        width = 30,
        side  = "left",
        preserve_window_proportions = false,
    },

    renderer = {
        group_empty = true,
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = true,
            },
        },
    },

    update_focused_file = {
        enable = true,
        update_root = false,  -- 파일 이동 시 루트 자동 변경 싫으면 false
    },

    git = {
        enable = true, -- 느리면 false로 끄기
        ignore = false,
    },

    filesystem_watchers = {
        enable = false, -- 더 가볍게 쓰고 싶으면 false (수동 새로고침 사용)
    },

    actions = {
        open_file = {
            quit_on_open = false, -- 파일 열면 트리 끔
            window_picker = {
                enable = true,
            },
        },
    },

    filters = {
        dotfiles = false, -- 숨김파일 감추려면 true
        custom   = { ".git" } -- 필요시 추가
    },
})
EOF

" 파일 트리 토글
nnoremap <silent> <leader>e :NvimTreeToggle<CR>
" 현재 파일 위치로 트리 포커스
nnoremap <silent> <leader>f :NvimTreeFindFile<CR>

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
imap <C-_> <C-o>gcc
nmap <C-_> gcc
xmap <C-_> gcgv

" Ctrl+/ 안될 때 우회용(~/.config/alacritty/alacritty.toml 참고)
imap ⎘ <C-o>gcc
nmap ⎘ gcc
xmap ⎘ gcgv

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

" nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

nnoremap <Leader>yf V/{<CR>%"+y

nnoremap K k
" nnoremap j gj
" nnoremap k gk
" vnoremap j gj
" vnoremap k gk

" 테마 토글 함수
function! ToggleColorScheme()
  if g:colors_name ==# 'dracula' " vscode+하양단색배경
    colorscheme vscode
    set background=light
    highlight Comment guifg=#6A9955 ctermfg=72 gui=italic " vscode 주석 색
    highlight Normal       ctermbg=NONE guibg=white
    highlight NormalNC     ctermbg=NONE guibg=white
    highlight NormalFloat  ctermbg=NONE guibg=white
    highlight FloatBorder  ctermbg=NONE guibg=white
    highlight SignColumn   ctermbg=NONE guibg=white
    highlight LineNr       ctermbg=NONE guibg=white
    highlight EndOfBuffer  ctermbg=NONE guibg=white
    highlight Search     guibg=#fffb90 guifg=#000000
    highlight IncSearch  guibg=#9bdcff guifg=#000000
    highlight CurSearch  guibg=#b2f59c guifg=#000000
  else " dracula+투명 배경
    colorscheme dracula
    set background=dark
    highlight Comment       guifg=#ffb86c ctermfg=215 gui=italic
    highlight Normal        guibg=NONE ctermbg=NONE 
    highlight NormalNC      guibg=NONE ctermbg=NONE 
    highlight NormalFloat   guibg=NONE ctermbg=NONE 
    highlight FloatBorder   guibg=NONE ctermbg=NONE 
    highlight SignColumn    guibg=NONE ctermbg=NONE 
    highlight LineNr        guibg=NONE ctermbg=NONE 
    highlight EndOfBuffer   guibg=NONE ctermbg=NONE 
    highlight Search    gui=underline,bold guibg=NONE guifg=#eeff41 cterm=underline ctermfg=190
    highlight IncSearch gui=underline,bold guibg=NONE guifg=#00ffc3 cterm=underline ctermfg=49
    highlight CurSearch gui=underline,bold guibg=NONE guifg=#00ffc3 cterm=underline ctermfg=49
  endif
endfunction

nnoremap <leader>t :call ToggleColorScheme()<CR>

" 파일명 지정 없이 nvim 열고 내용 쓴뒤 저장할 때 yazi로 경로 지정하게 해줌
function! s:SaveWithYazi() abort
    let chooser = tempname()
    let cwdfile = tempname()
    let cmd = printf('yazi --chooser-file=%s --cwd-file=%s',
                \ shellescape(chooser), shellescape(cwdfile))

    " create floating window
    let buf = nvim_create_buf(v:false, v:true)
    let width = float2nr(&columns * 0.90)
    let height = float2nr(&lines * 0.90)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)
    let win = nvim_open_win(buf, v:true, {
                \ 'relative': 'editor',
                \ 'width': width,
                \ 'height': height,
                \ 'row': row,
                \ 'col': col,
                \ 'style': 'minimal',
                \ 'border': 'rounded'
                \ })

    call termopen(cmd, {'on_exit': {job_id, code, event -> s:AfterYazi(chooser, cwdfile, win)}})
    startinsert
endfunction

function! s:AfterYazi(chooser, cwdfile, win) abort
    if exists('*nvim_win_is_valid') && nvim_win_is_valid(a:win)
        call nvim_win_close(a:win, v:true)
    endif

    let chosen = s:ReadFirstLine(a:chooser)
    if empty(chosen)
        let chosen = s:ReadFirstLine(a:cwdfile)
    endif

    if !empty(chosen)
        if filereadable(chosen)
            echoerr '파일 대신 폴더만 선택할 수 있습니다'
            call s:Cleanup(a:chooser, a:cwdfile)
            return
        endif

        if isdirectory(chosen)
            let name = input('File name: ')
            if empty(name)
                echoerr '파일 이름은 비워둘 수 없습니다'
                call s:Cleanup(a:chooser, a:cwdfile)
                return
            endif
            let target = chosen . '/' . name
        else
            let target = chosen
        endif
        execute 'silent keepalt file ' . fnameescape(target)
        write
    endif

    call s:Cleanup(a:chooser, a:cwdfile)
endfunction

function! s:ReadFirstLine(path) abort
    if filereadable(a:path)
        let l = readfile(a:path, '', 1)
        return len(l) ? l[0] : ''
    endif
    return ''
endfunction

function! s:Cleanup(c1, c2) abort
    if filereadable(a:c1) | call delete(a:c1) | endif
    if filereadable(a:c2) | call delete(a:c2) | endif
endfunction

nnoremap <leader>sw :call <SID>SaveWithYazi()<CR>

nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>

inoremap <C-Del> <C-O>dw
" ctrl+delete

inoremap <C-a> <Esc>ggVG
vnoremap <C-c> "+y
nnoremap <C-c> "+yl
inoremap <C-v> <C-r><C-o>+
inoremap <C-r> <C-r><C-o>
" insert <C-r>로 붙여넣는 거는 텍스트 붙여넣는 도중에도 에디터 자동 들여쓰기 등이 작동해서 이상해짐. 텍스트 전체를 한 단위로 한번에 넣으려면 normal모드에서 넣어야 함
