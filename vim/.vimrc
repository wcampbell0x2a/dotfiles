" Always display the status line, even if only one window is displayed
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

" Enable Solarized
set background=dark
colorscheme solarized

filetype indent on

" Better command-line completion
set wildmenu
set showcmd

" highlight matching braces
set showmatch

" Use case insensitive search, except when using capital letters
" set ignorecase
set smartcase

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

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

"Improved vim splits
set splitbelow
set splitright

" Show column at line 81
set colorcolumn=81
set cursorline

"Hightlight BadWhitespace
highlight BadWhitespaces ctermbg=red guibg=red
match BadWhitespaces /\s\+$/

"aspell shortcut
map  :w!<CR>:!aspell check %<CR>:e! %<CR>

"Move by display lines when word wrap works
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
onoremap <silent> j gj
onoremap <silent> k gk

set statusline=
set statusline+=%#WildMenu#
set statusline+=\ " "
set statusline+=%{gitbranch#name()}
set statusline+=\ "    "
set statusline+=%#Pmenu#
set statusline+=\ "    "
set statusline+=%m
set statusline+=\ %f
set statusline+=\ "    "
set statusline+=%#LineNr#
set statusline+=%=
set statusline+=%#Pmenu#
set statusline+=\ "    "
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ " "

"Vundle
so ~/.vim/plugins.vim
