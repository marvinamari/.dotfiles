-- Escape termcodes
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local keymap = require 'utils'.keymap
local opts = { noremap=true, silent=true }

keymap('n', '<Space>', '<NOP>', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Allow gf to open non-existent files
keymap('', 'gf', ':edit <cfile><CR>', {})

-- better window movement
keymap('n', '<C-h>', '<C-w>h', {silent = true})
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Clear search
vim.api.nvim_create_user_command('C', 'let @/=""', {})

-- Copy and paste
keymap('v', '<C-c>', '"+yi', { silent = true })
keymap('v', '<C-x>', '"+c', { silent = true })
keymap('v', '<C-v>', 'c<ESC>"+p', { silent = true })
keymap('v', '<C-V>', '<ESC>"+pa', { silent = true })

-- Neoclip
keymap('n', '<leader>cm', ':Telescope neoclip<CR>', opts)

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

-- Scroll
keymap('n', '<S-h>', '20zh', opts)
keymap('n', '<S-l>', '20zl', opts)

-- Move selected block in visual mode
keymap('x', 'K', ':move \'<-2<CR>gv-gv', opts)
keymap('x', 'J', ':move \'>+1<CR>gv-gv', opts)

-- Tab switch buffer
keymap('n', '<TAB>', ':bnext<CR>', opts) -- :BufferLineCycleNext
keymap('n', '<S-TAB>', ':bprevious<CR>', opts) -- :BufferLineCyclePrev

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
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- harpoon
keymap('n', '<leader>bb', ':lua require("harpoon.mark").add_file()<CR>', opts)
keymap('n', '<leader>br', ':lua require("harpoon.mark").rm_file()<CR>', opts)
keymap('n', '<leader>bc', ':lua require("harpoon.mark").clear_all()<CR>', opts)
keymap('n', '<leader>bl', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
keymap('n', '<leader>bn', ':lua require("harpoon.ui").nav_next()<CR>', opts)
keymap('n', '<leader>bp', ':lua require("harpoon.ui").nav_prev()<CR>', opts)
keymap('n', '<leader>b1', ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap('n', '<leader>b2', ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap('n', '<leader>b3', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap('n', '<leader>b4', ':lua require("harpoon.ui").nav_file(4)<CR>', opts)

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
keymap('n', '<leader>nr', ':NvimTreeRefresh<CR>', opts)
keymap('n', '<leader>nn', ':NvimTreeToggle<CR>', opts)
keymap('n', '<leader>nf', ':NvimTreeFindFile<CR>', opts)

-- git
keymap('n', '<leader>DL', ':diffget local<CR>', opts)
keymap('n', '<leader>DB', ':diffget base<CR>', opts)
keymap('n', '<leader>DR', ':diffget remote<CR>', opts)

-- nvim-dap
map('n', '<F2>', ":lua require('dap').toggle_breakpoint()<CR>")
map('n', '<F5>', ":lua require('dap').continue()<CR>")

map('n', '<F10>', ":lua require('dap').step_over()<CR>")
map('n', '<F11>', ":lua require('dap').step_into()<CR>")
map('n', '<S-F12>', ":lua require('dap').step_out()<CR>")

map('n',  '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>")
map('n',  '<leader>dC', ":lua require'dap'.close()<CR>")
map('n',  '<leader>dc', ":lua require'dap'.continue()<CR>")
map('n',  '<leader>dU', ":lua require'dap'.up()<CR>")
map('n',  '<leader>dD', ":lua require'dap'.down()<CR>")
map('n',  '<leader>d_', ":lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>")

map('n',  '<leader>dr', ":lua require'dap'.repl.toggle({}, 'vsplit')<CR><C-w>l")
map('n', '<Leader>dro', ":lua require('dap').repl.open()<CR>")
map('n', '<Leader>drl', ":lua require('dap').repl.run_last()<CR>")


map('n',  '<leader>de', ":lua require'dap'.set_exception_breakpoints({'all'})<CR>")
map('n', '<Leader>dbc', ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map('n', '<Leader>dbm', ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>")
map('n',  '<leader>da', ":lua require'debugHelper'.attach()<CR>")
map('n',  '<leader>dA', ":lua require'debugHelper'.attachToRemote()<CR>")

-- nvim-dap-ui
map('n',  '<leader>dh', ":lua require'dap.ui.variables'.hover()<CR>")
map('v',  '<leader>dv', ":lua require'dap.ui.variables'.visual_hover()<CR>")
map('n',  '<leader>d?', ":lua require'dap.ui.variables'.scopes()<CR>")
map('n', '<leader>dui', ":lua require('dapui').toggle()<CR>")
map('n', '<leader>duh', "<cmd>lua require'dap.ui.widgets'.hover()<CR>")
map('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
map('n', '<F4>', ":lua require('dapui').toggle()<CR>")


-- change list
map('n', '<leader>cl', ":changes<CR>", opts)

-- telescope-dap
map('n', '<leader>dtf', ":Telescope dap frames<CR>")
map('n', '<leader>dtc', ":Telescope dap commands<CR>")
map('n', '<leader>dto', ":Telescope dap configurations<CR>")
map('n', '<leader>dlb', ":Telescope dap list_breakpoints<CR>")
map('n', '<leader>dv', ":Telescope dap variables<CR>")

-- Telescope -- See `:help telescope.builtin`
vim.keymap.set("n", "<Leader>ff", ":lua require('telescope.builtin').find_files()<CR>", { desc = '[f]ind [f]iles' })
map("n", "<Leader>fb", ':lua require("telescope").extensions.file_browser.file_browser()<CR>')
map("n", "<Leader>fc", ":lua require('telescope.builtin').colorscheme()<CR>")
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map("n", "<Leader>fm", ":Telescope commands<CR>")
map("n", "<Leader>fj", ":Telescope jumplist<CR>")
map("n", "<Leader>fq", ":Telescope quickfix<CR>")
map("n", "<Leader>fh", ":Telescope quickfixhistory<CR>")
map("n", "<Leader>gg", ":Telescope live_grep<CR>")
map("n", "<Leader>go", ":lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>")
map("n", "<Leader>fr", ":Telescope marks<CR>")
map("n", "<Leader>fp", ":Telescope projects<CR>")
map("n", "<Leader>fgs", ":Telescope git_status<CR>")
map("n", "<Leader>fgf", ":Telescope git_files<CR>")
map("n", "<Leader>fgc", ":Telescope git_commits<CR>")
map("n", "<Leader>fgt", ":Telescope git_stash<CR>")
map("n", "<Leader>fgb", ":Telescope git_branches<CR>")

vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


-- neotest
map("n", "<leader>tr", ':lua require("neotest").run.run()<CR>')
map("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
map("n", "<leader>td", ':lua require("neotest").run.run({strategy = "dap"})<CR>', opts)
map("n", "<leader>ts", ':lua require("neotest").run.stop()<CR>', opts)
map("n", "<leader>ta", ':lua require("neotest").run.attach()<CR>', opts)
map("n", "<leader>tS", ':lua require("neotest").summary.toggle()<CR>', opts)
map("n", "<leader>to", ':lua require("neotest").summary.output()<CR>', opts)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
