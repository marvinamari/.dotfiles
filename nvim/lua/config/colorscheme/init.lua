--if vim.fn.has('termguicolors') == 1 then
--          vim.api.nvim_command('set termguicolors')
--ifend

--vim.cmd [[let g:airline_theme = 'sonokai']]
vim.g.airline_theme ='sonokai'
vim.g.sonokai_style = 'default'
vim.g.sonokai_cursor = 'orange'
vim.g.sonokai_menu_selection_background ='green'
vim.g.sonokai_diagnostic_text_highlight ='0'
vim.g.airline_theme='sonokai'

--vim.api.nvim_command('set termguicolors')

vim.api.nvim_command('colorscheme sonokai')
