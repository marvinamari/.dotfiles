return {
  'folke/trouble.nvim',
  'simrat39/symbols-outline.nvim',
  {
  'chentoast/marks.nvim'
  },
  {
    'rest-nvim/rest.nvim',
    event = "VeryLazy"
  },
  'kevinhwang91/nvim-bqf',
  {
  'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },
  --'onsails/lspkind.nvim',
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets'
    },
  },
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },
  {
     "ggandor/leap.nvim"
  },
  {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
  },
-- lsp
  {
    dir = '~/projects/roslyn.nvim'
  },
  {
    'mfussenegger/nvim-jdtls'
  },
  {
    --'folke/neodev.nvim'
  },
-- Editor
  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  },
  'windwp/nvim-autopairs',
  'p00f/nvim-ts-rainbow',
  { 'hoob3rt/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons', opt = true} },
  {'akinsho/nvim-bufferline.lua', dependencies = 'nvim-tree/nvim-web-devicons'},
  {"akinsho/toggleterm.nvim", tag = 'v2.2.1'},
  'kevinhwang91/nvim-hlslens',
  { "AckslD/nvim-neoclip.lua", --TODO fix
    dependencies = {
        {'kkharji/sqlite.lua', module = 'sqlite'},
      },
      config = function()
        require('neoclip').setup()
      end,
  },
    {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    },
-- Copilot
  -- "zbirenbaum/copilot.lua",
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   after = { "copilot.lua" },
  --   config = function ()
  --     require("copilot_cmp").setup()
  --   end
  -- },
  --'https://github.com/pmizio/typescript-tools.nvim'
-- Debug
  'mfussenegger/nvim-dap',
  'theHamsta/nvim-dap-virtual-text',
  'nvim-telescope/telescope-dap.nvim',
  'jbyuki/one-small-step-for-vimkind',
  { 'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap'} },

-- Test
  'vim-test/vim-test',
  {
    "nvim-neotest/neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "haydenmeade/neotest-jest",
      "Issafalcon/neotest-dotnet",
      "Decodetalkers/csharpls-extended-lsp.nvim",
      "stevanmilic/neotest-scala",
      "rouge8/neotest-rust",
      "mrcjkb/neotest-haskell",
      "nvim-neotest/neotest-vim-test",
    }
  },

-- Utility
  'BurntSushi/ripgrep',
  --use 'vijaymarupudi/nvim-fzf'
  'folke/which-key.nvim',
  'kdheepak/lazygit.nvim',
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },

  { -- Highlight, edit, and navigate code --
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    configs = {
            ignore_install = {"help", "vimdoc"}
        }
  },

  {
  'lewis6991/gitsigns.nvim',
  -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  },

    -- Useful status updates for LSP
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach'
  },
    'nvim-lua/lsp-status.nvim',

}

