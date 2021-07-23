-- enable ncm2 for all buffers
vim.api.nvim_command('autocmd BufEnter * call ncm2#enable_for_buffer()')
-- IMPORTANT: :help Ncm2PopupOpen for more information
vim.api.nvim_command('set completeopt=noinsert,menuone,noselect')
