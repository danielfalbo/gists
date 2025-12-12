syntax sync fromstart
syntax on
set background=dark

vmap < <gv
vmap > >gv

nmap Y y$

nmap Q @q

nmap j gj
nmap k gk
vmap j gj
vmap k gk

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

noremap <silent><cr> :wa<cr>

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set incsearch           " incremental search
set ignorecase		" ignore the case
set smartcase           " don't ignore the case if the pattern is uppercase
set ruler               " show cursor position
set autoindent
set backspace=2
set breakindent         " every wrapped line will continue visually indented
set linebreak           " don't split words
"set colorcolumn=80      " highlight 80th col

" persistent cursor position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$")
    \   | exe "normal! g`\"zz"
    \ | endif

let loaded_matchparen = 1   " Avoid the loading of match paren plugin
filetype plugin on

set clipboard=unnamed                   " macos system clipboard

set numberwidth=5                       " width of the line number column

" Grey line numbers
highlight LineNr ctermfg=grey ctermbg=NONE
" Highlight current line number
highlight CursorLineNr ctermfg=yellow ctermbg=NONE

" Dark grey background
highlight CursorLine cterm=NONE ctermbg=234
" Remove underline from current line number
highlight CursorLineNr cterm=NONE

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red
autocmd BufWinEnter,WinEnter * match TrailingWhitespace /\s\+$/

" use cursor shape as mode indicator
set noshowmode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set ttimeoutlen=10

" read .vimrc.local if present
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" show the status bar even with one buffer
set laststatus=2

hi User1 ctermfg=green ctermbg=black
hi User2 ctermfg=yellow ctermbg=black
hi User3 ctermfg=red ctermbg=black
hi User4 ctermfg=blue ctermbg=black
hi User5 ctermfg=white ctermbg=black

set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor
