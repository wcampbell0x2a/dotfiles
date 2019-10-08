set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/vim-gitbranch'
call vundle#end()

filetype plugin indent on

set updatetime=250
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
