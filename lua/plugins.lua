local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer-nvim/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

-- Automatically compile lazy loaders
vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'

-- Editor
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use 'sainnhe/sonokai'
  use 'norcalli/snippets.nvim'
  use 'windwp/nvim-autopairs'
  use 'p00f/nvim-ts-rainbow'
  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}

-- Debug
  use 'mfussenegger/nvim-dap'
  use { 'nvim-telescope/telescope-vimspector.nvim' }

-- Utility
--  use 'vim-test/vim-test'
--  use 'tpope/vim-fugitive'
  use 'vimwiki/vimwiki'
  use 'BurntSushi/ripgrep'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)


