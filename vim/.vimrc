set laststatus=2

filetype plugin indent on

"python settings
augroup python
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
augroup END

"cpp settings
augroup Cpp
    autocmd!
    autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

"Screen support
if &term =~ '^screen'
    set ttymouse=xterm2
endif

set modeline

if has('mouse')
  set mouse=a
endif

syntax enable
set background=dark
colorscheme solarized
filetype indent on
set wildmenu
" highlight matching braces
set showmatch

"show search results while typing, reset when in insert mode
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
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.cpp,*.hpp match BadWhitespaces /\s\+$/

"aspell shortcut
map  :w!<CR>:!aspell check %<CR>:e! %<CR>
