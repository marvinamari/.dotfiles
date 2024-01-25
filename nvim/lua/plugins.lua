return {
  'BurntSushi/ripgrep',
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    'm-demare/hlargs.nvim',
    config = function()
      require('hlargs').setup {
      }
      -- (You may omit the settings whose defaults you're ok with)
    end
  },
  -- Editor
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = "mocha",
        -- highlight_overrides = {
        --   mocha = function(colors)
        --     return {
        --       Visual = { bg = colors.sapphire }
        --     }
        --   end
        -- }

      })
    end
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },

}
