return {
    'rest-nvim/rest.nvim',
    event = "VeryLazy",
  config = function()
require('rest-nvim').setup({})
  end
}
