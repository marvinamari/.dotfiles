return {
  'BurntSushi/ripgrep',
  {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
  },
-- Editor
  {
  "navarasu/onedark.nvim",--"marko-cerovac/material.nvim",--"folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require('onedark').setup({
        style = 'dark'
      })
  end
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },

}

