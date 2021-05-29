-- Escape termcodes
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- Remap ESC
--vim.api.nvim_set_keymap('i', ';;', '<ESC>', { noremap = true, silent = true })

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- Moving to start or end of line (insert mode)
-- <C-o> switches vim to insert mode for one command
vim.api.nvim_set_keymap('i', t'<C-e>', '<C-o>$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', t'<C-a>', '<C-o>0', { noremap = true, silent = true })

-- Copy and paste
vim.api.nvim_set_keymap('v', '<C-c>', '"+yi', { silent = true })
vim.api.nvim_set_keymap('v', '<C-x>', '"+c', { silent = true })
vim.api.nvim_set_keymap('v', '<C-v>', 'c<ESC>"+p', { silent = true })
vim.api.nvim_set_keymap('v', '<C-V>', '<ESC>"+pa', { silent = true })

-- Move while insert mode 
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', {noremap = true, silent = true})

-- Move selected block in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- TODO fix this
-- resize with arrows
vim.cmd([[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]])

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>zz', ':echo yes', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<expr><TAB>', 'pumbisible() ? \"\\<C-n>\" : \"\\<TAB>\"', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<expr><ENTER>', 'pumbisible() ? \"\\<C-Y>\" : \"\\<ENTER>\"', { noremap = true, silent = true })
