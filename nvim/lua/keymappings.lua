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


-- Copy and paste
vim.api.nvim_set_keymap('v', '<C-c>', '"+yi', { silent = true })
vim.api.nvim_set_keymap('v', '<C-x>', '"+c', { silent = true })
vim.api.nvim_set_keymap('v', '<C-v>', 'c<ESC>"+p', { silent = true })
vim.api.nvim_set_keymap('v', '<C-V>', '<ESC>"+pa', { silent = true })
-- Better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })


-- Move while insert mode 
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', {noremap = true, silent = true})
-- Moving to start or end of line (insert mode)
-- <C-o> switches vim to insert mode for one command
vim.api.nvim_set_keymap('i', t'<C-e>', '<C-o>$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', t'<C-a>', '<C-o>0', { noremap = true, silent = true })


-- Move selected block in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})


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

-- nv-completion
--" Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_set_keymap('i' , '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })

-- nv-nvim-tree
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- nv-nvim-dapp
vim.api.nvim_set_keymap( 'n',  '<leader>dh', ":lua require'dap'.toggle_breakpoint()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<S-k>',      ":lua require'dap'.step_out()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<S-l>',      ":lua require'dap'.step_into()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<S-j>',      ":lua require'dap'.step_over()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>ds', ":lua require'dap'.stop()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>dn', ":lua require'dap'.continue()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>dk', ":lua require'dap'.up()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>dj', ":lua require'dap'.down()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>d_', ":lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>di', ":lua require'dap.ui.variables'.hover()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>dr', ":lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l", {noremap = true})
vim.api.nvim_set_keymap( 'v',  '<leader>di', ":lua require'dap.ui.variables'.visual_hover()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>d?', ":lua require'dap.ui.variables'.scopes()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>de', ":lua require'dap'.set_exception_breakpoints({'all'})<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>da', ":lua require'debugHelper'.attach()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>dA', ":lua require'debugHelper'.attachToRemote()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>di', ":lua require'dap.ui.widgets'.hover()<CR>", {noremap = true})
vim.api.nvim_set_keymap( 'n',  '<leader>d?', ":lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", {noremap = true})

-- dapp & Telescope
vim.api.nvim_set_keymap( 'n', '<leader>df', ':Telescope dap frames<CR>', { noremap = true})
vim.api.nvim_set_keymap( 'n', '<leader>dc', ':Telescope dap commands<CR>', { noremap = true})
vim.api.nvim_set_keymap( 'n', '<leader>dlb', ':Telescope dap list_breakpoints<CR>', { noremap = true})

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>zz', ':echo yes', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<expr><TAB>', 'pumbisible() ? \"\\<C-n>\" : \"\\<TAB>\"', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<expr><ENTER>', 'pumbisible() ? \"\\<C-Y>\" : \"\\<ENTER>\"', { noremap = true, silent = true })
