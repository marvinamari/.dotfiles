-- Escape termcodes
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local keymap = require 'utils'.keymap
local opts = { noremap=true, silent=true }

keymap('n', '<Space>', '<NOP>', opts)
vim.g.mapleader = ' '

-- Format
--keymap('n', '<leader>f', ':Format<cr>')

-- Remap ESC
--keymap('i', ';;', '<ESC>', opts)

-- Allow gf to open non-existent files
keymap('', 'gf', ':edit <cfile><CR>', {})

-- better window movement
keymap('n', '<C-h>', '<C-w>h', {silent = true})
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)


-- Copy and paste
keymap('v', '<C-c>', '"+yi', { silent = true })
keymap('v', '<C-x>', '"+c', { silent = true })
keymap('v', '<C-v>', 'c<ESC>"+p', { silent = true })
keymap('v', '<C-V>', '<ESC>"+pa', { silent = true })

-- Better indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)


-- Move while insert mode
keymap('i', '<C-l>', '<Right>', opts)
keymap('i', '<C-h>', '<Left>', opts)
keymap('i', '<C-j>', '<Down>', opts)
keymap('i', '<C-k>', '<Up>', opts)

-- Moving to start or end of line (insert mode)
-- <C-o> switches vim to insert mode for one command
keymap('i', t'<C-e>', '<C-o>$', opts)
keymap('i', t'<C-a>', '<C-o>0', opts)


-- Move selected block in visual mode
keymap('x', 'K', ':move \'<-2<CR>gv-gv', opts)
keymap('x', 'J', ':move \'>+1<CR>gv-gv', opts)

-- Tab switch buffer
keymap('n', '<TAB>', ':bnext<CR>', opts)
keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

-- Replace word under cursor and press to repeat operation, n to skip
keymap('n', 's*', ":let @/='<'.expand('<cword>').'>'<CR>cgn", opts)
keymap('x', 's*', 'sy:let @/=@s<CR>cgn', opts)
keymap('n', '<leader>rn', '%s///g<Left><Left>', {noremap = true, silent = false})
keymap('x', '<leader>rn', '%s///g<Left><Left>', opts)

-- TODO fix this
-- resize with arrows
vim.cmd([[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]])

-- LSP
keymap('n', '<leader>e', ':lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', ':lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<leader>q', ':lua vim.diagnostic.setloclist()<CR>', opts)

keymap('n', '<leader>gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', '<leader>gd', ':lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', '<leader>K', ':lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<leader>gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', '<leader>hh', ':lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
keymap('n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
keymap('n', '<leader>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
keymap('n', '<leader>D', ':lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '<leader>gr', ':lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<leader>F', ':lua vim.lsp.buf.formatting({ async = true })<CR>', opts)


-- harpoon
keymap('n', '<leader>hm', ':lua require("harpoon.mark").add_file()<CR>', opts)
keymap('n', '<leader>hr', ':lua require("harpoon.mark").rm_file()<CR>', opts)
keymap('n', '<leader>hc', ':lua require("harpoon.mark").clear_all()<CR>', opts)
keymap('n', '<leader>ht', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
keymap('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', opts)
keymap('n', '<leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', opts)
keymap('n', '<leader>h1', ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap('n', '<leader>h2', ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap('n', '<leader>h3', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap('n', '<leader>h4', ':lua require("harpoon.ui").nav_file(4)<CR>', opts)

-- toggleterm
keymap('n', '<leader>tt', ':ToggleTerm size=20 direction=horizontal<CR>', opts)
keymap('n', '<leader>tv', ':ToggleTerm size=110 direction=vertical<CR>', opts)
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead of term://*
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction= "float"
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})


-- nv-nvim-tree
keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', opts)
keymap('n', '<leader>n', ':NvimTreeToggle<CR>', opts)
keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', opts)

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
map('n', '<leader>dui', ":lua require('dapui').toggle()<CR>")
map('n', '<leader>duh', "<cmd>lua require'dap.ui.widgets'.hover()<CR>")
map('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
--map('n', '<leader>dui', ":lua require('dapui').toggle()<CR>")
map('n', '<F4>', ":lua require('dapui').toggle()<CR>")


-- telescope-dap
map('n', '<leader>df', ":Telescope dap frames<CR>")
map('n', '<leader>dcc', ":Telescope dap commands<CR>")
map('n', '<leader>dco', ":Telescope dap configurations<CR>")
map('n', '<leader>dlb', ":Telescope dap list_breakpoints<CR>")
map('n', '<leader>dv', ":Telescope dap variables<CR>")

-- Telescope
map("n", "<Leader>fff", ":lua require('telescope.builtin').find_files()<CR>")
map("n", "<Leader>ffb", ':lua require("telescope").extensions.file_browser.file_browser()<CR>')
map("n", "<Leader>fo", ":lua require('telescope.builtin').oldfiles()<CR>")
map("n", "<Leader>fc", ":lua require('telescope.builtin').colorscheme()<CR>")
map("n", "<Leader>fb", ":lua require('telescope.builtin').buffers()<CR>")
map("n", "<Leader>fm", ":Telescope commands<CR>")
map("n", "<Leader>fq", ":Telescope quick_fix<CR>")
map("n", "<Leader>fgg", ":Telescope live_grep<CR>")
map("n", "<Leader>fgo", ":lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>")
map("n", "<Leader>fr", ":Telescope marks<CR>")
map("n", "<Leader>fp", ":Telescope projects<CR>")
map("n", "<Leader>fgs", ":Telescope git_status<CR>")
map("n", "<Leader>fgf", ":Telescope git_files<CR>")
map("n", "<Leader>fgc", ":Telescope git_commits<CR>")
map("n", "<Leader>fgt", ":Telescope git_stash<CR>")
map("n", "<Leader>fgb", ":Telescope git_branches<CR>")

-- neotest
map("n", "<leader>ntt", ':lua require("neotest").run.run()<CR>')
map("n", "<leader>ntf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
map("n", "<leader>ntd", ':lua require("neotest").run.run({strategy = "dap"})<CR>', opts)
map("n", "<leader>nts", ':lua require("neotest").run.stop()<CR>', opts)
map("n", "<leader>nta", ':lua require("neotest").run.attach()<CR>', opts)
map("n", "<leader>ns", ':lua require("neotest").summary.toggle()<CR>', opts)
map("n", "<leader>nto", ':lua require("neotest").summary.output()<CR>', opts)

-- Bufferline
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
