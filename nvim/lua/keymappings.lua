-- Escape termcodes
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local keymap = require 'utils'.keymap

keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- Remap ESC
--keymap('i', ';;', '<ESC>', { noremap = true, silent = true })

-- Allow gf to open non-existent files
keymap('', 'gf', ':edit <cfile><CR>')

-- better window movement
keymap('n', '<C-h>', '<C-w>h', {silent = true})
keymap('n', '<C-j>', '<C-w>j', {silent = true})
keymap('n', '<C-k>', '<C-w>k', {silent = true})
keymap('n', '<C-l>', '<C-w>l', {silent = true})


-- Copy and paste
keymap('v', '<C-c>', '"+yi', { silent = true })
keymap('v', '<C-x>', '"+c', { silent = true })
keymap('v', '<C-v>', 'c<ESC>"+p', { silent = true })
keymap('v', '<C-V>', '<ESC>"+pa', { silent = true })

-- Better indenting
keymap('v', '<', '<gv', { noremap = true, silent = true })
keymap('v', '>', '>gv', { noremap = true, silent = true })


-- Move while insert mode 
keymap('i', '<C-l>', '<Right>', {noremap = true, silent = true})
keymap('i', '<C-h>', '<Left>', {noremap = true, silent = true})
keymap('i', '<C-j>', '<Down>', {noremap = true, silent = true})
keymap('i', '<C-k>', '<Up>', {noremap = true, silent = true})

-- Moving to start or end of line (insert mode)
-- <C-o> switches vim to insert mode for one command
keymap('i', t'<C-e>', '<C-o>$', { noremap = true, silent = true })
keymap('i', t'<C-a>', '<C-o>0', { noremap = true, silent = true })


-- Move selected block in visual mode
keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})


-- Tab switch buffer
keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- TODO fix this
-- resize with arrows
vim.cmd([[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]])

-- nv-completion
--" Use <Tab> and <S-Tab> to navigate through popup menu
keymap('i' , '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })

-- nv-nvim-tree
keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- dapp & Telescope
keymap( 'n', '<leader>df', ':Telescope dap frames<CR>', { noremap = true})
keymap( 'n', '<leader>dc', ':Telescope dap commands<CR>', { noremap = true})
keymap( 'n', '<leader>dlb', ':Telescope dap list_breakpoints<CR>', { noremap = true})

-- Telescope
keymap('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
keymap('n', '<Leader>zz', ':echo yes', { noremap = true, silent = false })
keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
keymap('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
keymap('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })

keymap('i', '<expr><TAB>', 'pumbisible() ? \"\\<C-n>\" : \"\\<TAB>\"', { noremap = true, silent = true })
keymap('i', '<expr><ENTER>', 'pumbisible() ? \"\\<C-Y>\" : \"\\<ENTER>\"', { noremap = true, silent = true })
