-- Escape termcodes
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local keymap = require 'utils'.keymap

keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- Format
keymap('n', '<leader>f', ':Format<cr>')

-- Remap ESC
keymap('i', ';;', '<ESC>', { noremap = true, silent = true })

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

-- Replace word under cursor and press to repeat operation, n to skip
keymap('n', 's*', ":let @/='<'.expand('<cword>').'>'<CR>cgn", {noremap = true, silent = true})
keymap('x', 's*', 'sy:let @/=@s<CR>cgn', {noremap = true, silent = true})
keymap('n', '<leader>rn', '%s///g<Left><Left>', {noremap = true, silent = false})
keymap('x', '<leader>rn', '%s///g<Left><Left>', {noremap = true, silent = true})

-- TODO fix this
-- resize with arrows
vim.cmd([[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]])


-- nv-nvim-tree
keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- nvim-dap
map('n', '<F2>', ":lua require('dap').toggle_breakpoint()<CR>")
map('n', '<F5>', ":lua require('dap').continue()<CR>")

map('n', '<F10>', ":lua require('dap').step_over()<CR>")
map('n', '<F11>', ":lua require('dap').step_into()<CR>")
map('n', '<S-F12>', ":lua require('dap').step_out()<CR>")

map('n',  '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>")
map('n',  '<leader>dss', ":lua require'dap'.close()<CR>")
map('n',  '<leader>dsc', ":lua require'dap'.continue()<CR>")
map('n',  '<leader>dsu', ":lua require'dap'.up()<CR>")
map('n',  '<leader>dsd', ":lua require'dap'.down()<CR>")
map('n',  '<leader>d_', ":lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>")

map('n',  '<leader>dr', ":lua require'dap'.repl.toggle({}, 'vsplit')<CR><C-w>l")
map('n', '<Leader>dro', ":lua require('dap').repl.open()<CR>")
map('n', '<Leader>drl', ":lua require('dap').repl.run_last()<CR>")


map('n',  '<leader>de', ":lua require'dap'.set_exception_breakpoints({'all'})<CR>")
map('n', '<Leader>dbc', ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map('n', '<Leader>dbm', ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>")
--map('n',  '<leader>da', ":lua require'debugHelper'.attach()<CR>")
--map('n',  '<leader>dA', ":lua require'debugHelper'.attachToRemote()<CR>")

-- nvim-dap-ui
map('n',  '<leader>dhh', ":lua require'dap.ui.variables'.hover()<CR>")
map('v',  '<leader>dhv', ":lua require'dap.ui.variables'.visual_hover()<CR>")
map('n',  '<leader>d?', ":lua require'dap.ui.variables'.scopes()<CR>")
map('n', '<leader>di', ":lua require('dapui').toggle()<CR>")
map('n', '<leader>duh', "<cmd>lua require'dap.ui.widgets'.hover()<CR>")
map('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
map('n', '<leader>dui', ":lua require('dapui').toggle()<CR>")
map('n', '<F4>', ":lua require('dapui').toggle()<CR>")


-- telescope-dap
map('n', '<leader>df', ":Telescope dap frames<CR>")
map('n', '<leader>dcc', ":Telescope dap commands<CR>")
map('n', '<leader>dco', ":Telescope dap configurations<CR>")
map('n', '<leader>dlb', ":Telescope dap list_breakpoints<CR>")
map('n', '<leader>dv', ":Telescope dap variables<CR>")

-- Telescope
map("n", "<Leader>fff", ":Telescope find_files<CR>")
map("n", "<Leader>ffb", ':lua require("telescope").extensions.file_browser.file_browser()<CR>')
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")
map("n", "<Leader>fc", ":Telescope colorscheme<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>fm", ":Telescope commands<CR>")
map("n", "<Leader>fq", ":Telescope quick_fix<CR>")
map("n", "<Leader>fl", ":Telescope live_grep<CR>")
map("n", "<Leader>fr", ":Telescope marks<CR>")
map("n", "<Leader>fp", ":Telescope projects<CR>")
map("n", "<Leader>fgs", ":Telescope git_status<CR>")
map("n", "<Leader>fgf", ":Telescope git_files<CR>")
map("n", "<Leader>fgc", ":Telescope git_commits<CR>")
map("n", "<Leader>fgb", ":Telescope git_branches<CR>")
map("n", "<Leader>fgt", ":Telescope git_stash<CR>")

-- keymap('i', '<expr><TAB>', 'pumbisible() ? \'\\<C-n>\' : \'\\<TAB>\'', { noremap = true, silent = true })
-- keymap('i', '<expr><ENTER>', 'pumbisible() ? \'\\<C-Y>\' : \'\\<ENTER>\'', { noremap = true, silent = true })

--' These commands will navigate through buffers in order regardless of which mode you are using
--' e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
--nnoremap <silent>[b :BufferLineCycleNext<CR>
--nnoremap <silent>b] :BufferLineCyclePrev<CR>

--' These commands will move the current buffer backwards or forwards in the bufferline
--nnoremap <silent><mymap> :BufferLineMoveNext<CR>
--nnoremap <silent><mymap> :BufferLineMovePrev<CR>

--' These commands will sort buffers by directory, language, or a custom criteria
--nnoremap <silent>be :BufferLineSortByExtension<CR>
--nnoremap <silent>bd :BufferLineSortByDirectory<CR>
--nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>
