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
  use {'wbthomason/packer.nvim', opt = true} -- Package manager

  --  Language Protocol Server
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jose-elias-alvarez/null-ls.nvim"
  }

  -- Autocomplete
  use { 'ms-jpq/coq_nvim', branch= 'coq' }
  use { 'ms-jpq/coq.artifacts', branch= 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch= '3p' }
  use({"L3MON4D3/LuaSnip", tag = "v1.0.0"})

-- Editor
  use 'themercorp/themer.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/snippets.nvim'
  use 'windwp/nvim-autopairs'
  use 'kyazdani42/nvim-tree.lua'
  use 'p00f/nvim-ts-rainbow'
  use 'gpanders/editorconfig.nvim'
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
  use {"akinsho/toggleterm.nvim", tag = 'v2.2.1'}

-- Debug
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text' 
  use 'nvim-telescope/telescope-dap.nvim'
  use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }
  use 'nvim-neotest/neotest'

-- Utility
  use 'BurntSushi/ripgrep'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'folke/which-key.nvim'
  use 'TimUntersberger/neogit'
  use 'jamestthompson3/nvim-remote-containers'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  
end)


