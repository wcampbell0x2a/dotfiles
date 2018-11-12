set laststatus=2

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif


if has('mouse')
  set mouse=a
endif

syntax enable
set background=dark
colorscheme solarized
filetype indent on
set wildmenu
set showmatch
set incsearch
nnoremap i :noh<cr>i

set hlsearch

"allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set splitbelow
set splitright

set colorcolumn=81

"Hightlight BadWhitespace
highlight BadWhitespaces ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.cpp match BadWhitespaces /\s\+$/

"aspell shortcut
map  :w!<CR>:!aspell check %<CR>:e! %<CR>
