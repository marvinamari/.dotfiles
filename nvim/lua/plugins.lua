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

  --  Language Protocol Server
  use {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
      }

  -- Autocomplete
  use 'ncm2/ncm2'
  use 'roxma/nvim-yarp'
  use 'ncm2/ncm2-vim-lsp'

-- Editor
  use 'kyazdani42/nvim-web-devicons'
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use 'sainnhe/sonokai'
  use 'norcalli/snippets.nvim'
  use 'windwp/nvim-autopairs'
  use 'kyazdani42/nvim-tree.lua'
  use 'p00f/nvim-ts-rainbow'
  use 'gpanders/editorconfig.nvim'
  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
  --- Dart/Flutter
  use 'akinsho/flutter-tools.nvim'

-- Debug
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text' 
  use 'nvim-telescope/telescope-dap.nvim'
  use 'mfussenegger/nvim-dap-python'
  use 'Pocco81/DAPInstall.nvim'
  use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }
  use {
        'rcarriga/vim-ultest',
        config = "require('config.ultest').post()",
        run = ":UpdateRemotePlugins",
        requires = {'vim-test/vim-test'}
      }

-- Utility
  use 'vimwiki/vimwiki'
  use 'BurntSushi/ripgrep'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'folke/which-key.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'TimUntersberger/neogit'
  use 'jamestthompson3/nvim-remote-containers'
  
end)


