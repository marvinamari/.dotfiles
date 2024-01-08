return {
  'hedyhli/outline.nvim',
  -- lazy = true,
  config = function()
    require("outline").setup({
      outline_window = {
        position = 'right',
      }
    })
  end
}
