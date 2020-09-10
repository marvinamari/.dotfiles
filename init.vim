" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
" update &runtimepath and initialize plugin system
" Automatically executes `filetype plugin indent` on and `syntax enable`

"Language Server Protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Design
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"Multi Cursor
"Plug 'vim-multiple-cursors'

"Run tests
"Plug 'janko/vim-test'

"Python
Plug 'vim-scripts/indentpython.vim'
Plug 'majutsushi/tagbar'

"Color Scheme
Plug 'tomasr/molokai'
Plug 'vim-syntastic/syntastic'

" Utility
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'benmills/vimux'
Plug 'vimwiki/vimwiki'
call plug#end()

" =====================================
"

" Show trailing whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhiteSpace ctermbg=red guibg=red
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"Set color scheme
let g:molokai_original = 1
colorscheme molokai
"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile<Paste>
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" :h laststatus for man page,this was required because airline did not
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

"Disable showmode since using airline
set noshowmode
filetype plugin indent on

"show existing tab with 4 spaces width
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set softtabstop=4

"Disable line wrapping
set nowrap

"Syntax highlighting
syntax on

"Scroll a bit horizontally when at the end of line
set sidescroll=6

"Highlight matches when searching
set hlsearch

"Open new split panes to right and below
set splitright
set splitbelow

" Highlight current line
set cursorline
set showcmd

"Show line numbers
set number
set numberwidth=2

" Enable Mouse
"set mouse=a " on OSX press alt and click
" Easier moving of code blocks
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Folding
"au BufNewFile,BufRead *.py \
"    set foldmethod=indent
"nnoremap <space> za

" MSC
:imap ;; <Esc>

" let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
" Disable multiple swap file events if having issues running tests
" Test suite running multiple times
"set nobackup
"set nowritebackup
"set noswapfile

" Make search case insensitive
"set hlsearch
"set incsearch
"set ignorecase
"set smartcase

"Git prompt
" display incomplete commands
