-- General settings
local wo = vim.wo
local g = vim.g
local opt = vim.opt

vim.cmd("set autoread")
vim.cmd("set modifiable")
-- Colorscheme
vim.cmd("colorscheme catppuccin")
--vim.cmd("colorscheme tokyonight-moon")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- disable language provider support for languages (lua and vimscript plugins only)
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_ruby_provider = 0

vim.cmd[[filetype plugin on]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Editor
opt.backup = false
opt.wrap = false
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8' -- The encoding written to file
--opt.termencoding = 'utf-8'
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
--vim.wo.wrap = false -- Display long lines as just one line
--vim.cmd('syntax on') -- move to next line with theses keys
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.cmdheight = 2 -- More space for displaying messages
vim.o.mouse = 'a' -- Enable your mouse
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
--vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms, this causes leader key not to work
vim.o.clipboard = 'unnamedplus' -- Copy paste between vim and everything else
vim.cmd[[ set dir=~/neovim/swaps ]]

--vim.opt.foldmethod="indent"

vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.expandtab=true
vim.opt.smarttab=true
vim.opt.copyindent=true

-- highlight color
--vim.cmd[[ set nowrap ]]
vim.cmd[[ set colorcolumn=80,120 ]]
--vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg=0, bg=LightGrey })
--vim.api.nvim_set_hl(0, "Normal", { ctermfg=White,  ctermbg=Black })

--vim.cmd[[ let g:vimwiki_list = \[{'path':'~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}\] ]]
--vim.cmd[[ let g:vimwiki_ext2syntax = {'.md':'markdown', '.markdown': 'markdown', '.mdown': 'markdown'} ]]

vim.g.vimwiki_markdown_link_ext = 1
vim.g.wildmenu=true
vim.o.sidescrolloff=7
vim.o.hlsearch=true
vim.o.splitright=true
vim.o.splitbelow=true
vim.o.cursorline=true
vim.o.showcmd=true
vim.g.syntax=true
vim.wo.number=true
vim.wo.relativenumber=true
vim.wo.numberwidth=2
vim.o.scrolloff=7
vim.g.noswapfile=true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Identify white space
vim.cmd([[
set list listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>
]])

-- set Vim-specific sequences for RGB colors
vim.cmd[["set t_8f=^[[38;2;%lu;%lu;%lum"]]
vim.cmd[["set t_8b=^[[48;2;%lu;%lu;%lum"]]

if vim.fn.has('termguicolors') == 1 then
    vim.api.nvim_command('set termguicolors')
end

-- vim.opt.guicursor = "a:block"

-- Windows Settings
if vim.fn.has('win32') == 1 then
  vim.g.sqlite_clib_path = 'C:/sqlite3.dll'
  vim.cmd[[let &shell = executable('pwsh') ? 'pwsh' : 'powershell']]

  local powershell_options = {
  shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
  shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  shellquote = "",
  shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end
