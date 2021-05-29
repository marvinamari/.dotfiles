" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')
 
"Language Server Protocol
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

Plug 'preservim/nerdtree'

" update &runtimepath and initialize plugin system
" Automatically executes `filetype plugin indent` on and `syntax enable`

"Design
Plug 'vim-airline/vim-airline'

"Plug 'dense-analysis/ale'
"Python
Plug 'vim-scripts/indentpython.vim'
Plug 'majutsushi/tagbar'

"Color Scheme
Plug 'rafi/awesome-vim-colorschemes'
"Plug 'vim-syntastic/syntastic'

" Utility
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" ======================================
" LSP Settings
source ~/.config/nvim/plug-config/lsp-config.vim
let NERDTreeShowHidden=1
let NERDTreeMouseMode = 2
map <C-n> :NERDTreeToggle<CR>
set mouse=a

" =====================================
" Plugin Configuration
lua << EOF
luafile ~/.config/nvim/plug-config/compe-config.lua
luafile ~/.config/nvim/plug-config/python-ls.lua
EOF


" =====================================
"
" Coc Settings
"let g:coc_global_extensions = [
"            \'coc-pairs',
"            \'coc-tsserver',
"            \'coc-snippets',
"            \'coc-prettier',
"            \'coc-json',
"            \'coc-python',
"            \'coc-css',
"            \'coc-java',
"            \'coc-emmet',
"            \'coc-git'
"            \'coc-eslint',
"            \'coc-graphql',
"            \'coc-html',
"            \'coc-markdownlint',
"            \'coc-yaml'
"            \]

"Let ALE lint
"let g:ale_linters = {
"\   'python': ['flake8', 'pylint'],
"\   'javascript': ['eslint'],
"\   'vue': ['eslint']
"\}
"let g:ale_fix_on_save = 1

" Show trailing whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhiteSpace ctermbg=244 guibg=244
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"Set color scheme
"let g:airline_theme='luna'
let g:airline_theme='afterglow'
let g:afterglow_blackout=1
colorscheme afterglow

"Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"Prettier


" :h laststatus for man page,this was required because airline did not
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

"Disable showmode since using airline
set noshowmode
filetype plugin indent on

" Editor
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"show existing tab with 4 spaces width
set tabstop=4
set shiftwidth=4

"au Filetype python setl et ts=4 sw=4
set expandtab
set smarttab
set softtabstop=4

"Disable line wrapping
set nowrap

"VimWiki and Syntax highlighting
set nocompatible
filetype plugin on
syntax on

let g:vimwiki_list = [{'path':'~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md':'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Makes vimwiki links as [text](text.md) instead of [text](text)
let g:vimwiki_markdown_link_ext = 1

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


"IDE Features
"Make enter select autocomplete
"Cycle through popup with tab
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr> <ENTER> pumvisible() ? "\<C-Y>":"\<ENTER>"
" Enable Mouse
"set mouse=a " on OSX press alt and click
" Easier moving of code blocks
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Copy And Paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
vmap <C-v> <ESC>"+pa
map <S-Up> <C-Y>
map <S-Down> <C-E>

" Move right or left while in insert mode
" <C-o> switches vim to insert mode for one command
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

"Terminal mode

" let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" MSC
:let mapleader=","
:imap ;; <Esc>
" Disable multiple swap file events if having issues running tests
" Test suite running multiple times
"set nobackup
"set nowritebackup
"set noswapfile

" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

"Git prompt
" display incomplete commands
