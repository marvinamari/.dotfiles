return {
  'folke/trouble.nvim',
  'simrat39/symbols-outline.nvim',
  'chentoast/marks.nvim',
  'rest-nvim/rest.nvim',
  'sindrets/diffview.nvim',
  'kevinhwang91/nvim-bqf',
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
      "danymat/neogen",
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = true,
      -- Uncomment next line if you want to follow only stable versions
      -- version = "*"
  },
  {
     "ggandor/leap.nvim"
  },
-- Editor
  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  },
  'Hoffs/omnisharp-extended-lsp.nvim',
  'windwp/nvim-autopairs',
  'p00f/nvim-ts-rainbow',
  { 'hoob3rt/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons', opt = true} },
  {'akinsho/nvim-bufferline.lua', dependencies = 'nvim-tree/nvim-web-devicons'},
  {"akinsho/toggleterm.nvim", tag = 'v2.2.1'},
  'kevinhwang91/nvim-hlslens',
  'numToStr/Comment.nvim',
  'sQVe/sort.nvim',
  { "AckslD/nvim-neoclip.lua",
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
      "stevanmilic/neotest-scala",
      "rouge8/neotest-rust",
      "mrcjkb/neotest-haskell",
      "nvim-neotest/neotest-vim-test",
    }
  },

-- Utility
  'BurntSushi/ripgrep',
  --use 'vijaymarupudi/nvim-fzf'
  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  'folke/which-key.nvim',
  'kdheepak/lazygit.nvim',
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },

  {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  },

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

  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach'
    }

}

