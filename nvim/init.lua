-- Convert invit.vim to init.lua : https://www.khuedoan.com/posts/convert-from-init-vim-to-init-lua/    
require('plugins')
--vim.api.nvim_command([[
--autocmd BufWritePost plugins.lua PackerCompile
--]])
require('settings')
require('nv-colorscheme')
require('keymappings')
require('nv-completion')
require('nv-treesitter')
require('nv-telescope')
require('nv-bufferline')
require('nv-lualine')
require('nv-web_devicons')
require('nv-nvim_tree')
require('nv-nvimdap')
require('nv-ts_rainbow')
require('nv-whichkey')
-- LSP
require('lsp-config')
