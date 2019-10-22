" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
" update &runtimepath and initialize plugin system
" Automatically executes `filetype plugin indent` on and `syntax enable`
call plug#end()

" =====================================
"

filetype plugin indent on
"show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
