-- Install packer
local get_os_type = function()
    local operating_system = package.config:sub(1,1)
    local result = ""
    if operating_system == '/' then
       result = "unix"
    elseif operating_system == '\\' or operating_system == "\\" then
        result = "windows"
    end
    return result
end

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if get_os_type() == "windows" then
    install_path = "$env:LOCALAPPDATA\\nvim-data\\site\\pack\\packer\\start\\packer.nvim"
end

local ensure_packer = function()
  local fn = vim.fn
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local is_bootstrap = ensure_packer()

require('packer').startup(function(use)
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true} -- Package manager

   use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-lua/lsp-status.nvim'
    },
  }

  use 'folke/trouble.nvim'

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

-- Editor
  use 'themercorp/themer.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'windwp/nvim-autopairs'
  use 'p00f/nvim-ts-rainbow'
  use 'gpanders/editorconfig.nvim'
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
  use {"akinsho/toggleterm.nvim", tag = 'v2.2.1'}
  use 'ThePrimeagen/harpoon'
  use 'kevinhwang91/nvim-hlslens'
  use 'lvimuser/lsp-inlayhints.nvim'
  use 'numToStr/Comment.nvim'
  use 'sQVe/sort.nvim'
  use { "AckslD/nvim-neoclip.lua",
    requires = {
        {'kkharji/sqlite.lua', module = 'sqlite'},
      },
      config = function()
        require('neoclip').setup()
      end,
    }

-- Copilot
  use { "zbirenbaum/copilot.lua" }
  use {
    "zbirenbaum/copilot-cmp",
    cmd = "Copilot",
    event = "InsertEnter",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

-- Debug
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'jbyuki/one-small-step-for-vimkind'
  use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }

-- Test
  use 'vim-test/vim-test'
  use {
    "nvim-neotest/neotest",
    requires = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "haydenmeade/neotest-jest",
      "Issafalcon/neotest-dotnet",
      "stevanmilic/neotest-scala",
      "rouge8/neotest-rust",
      "mrcjkb/neotest-haskell",
      "nvim-neotest/neotest-vim-test",
    }
  }

-- Utility
  use 'BurntSushi/ripgrep'
  --use 'vijaymarupudi/nvim-fzf'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'folke/which-key.nvim'
  use 'kdheepak/lazygit.nvim'
  use 'jamestthompson3/nvim-remote-containers'
  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  use { -- Highlight, edit, and navigate code --
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter --
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use {
  'lewis6991/gitsigns.nvim',
  -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }
  -- Add custom plugins to packer from /nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'config.custom')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)


-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
