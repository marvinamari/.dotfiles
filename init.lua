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
require('nv-autopairs')
require('nv-ts_rainbow')
-- LSP
require('lsp-config')
