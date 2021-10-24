" Always display the status line, even if only one window is displayed
set laststatus=2

filetype plugin indent on

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

"Screen support
if &term =~ '^screen'
    set ttymouse=xterm2
endif

set modeline

if has('mouse')
  set mouse=a
endif

" mouse_sgr support
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

syntax enable

" Enable Solarized
set background=dark
colorscheme solarized

filetype indent on

" Better command-line completion
set wildmenu
set showcmd

" Display tabs as errors
set list
set listchars=tab:I-
match Error /\t/

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
set colorcolumn=101
set cursorline

"Hightlight BadWhitespace
highlight ExtraWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END
function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

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
set statusline+=\ %F
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
set guitablabel=\[%N\]\ %t\ %M

"Vundle
so ~/.vim/plugins.vim
