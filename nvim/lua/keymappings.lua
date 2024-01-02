-- echo v:lua.vim.uv.os_name().sysname -- lua print(vim.uv.os_uname().sysname)
-- Go to previous location Ctrl + o
-- Go to next location Ctrl + i
-- Go to next method, change, diagnostic [] m|c|d
-- Increment Decrement number Ctrl-A Ctrl-X
-- substitue in block <,>s/old/new/g
-- jump to matching brace %
--

-- variables
vim.g.maplocalleader = '\\'

local keymap = require 'utils'.keymap

-- Escape termcodes
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end


keymap('n', '<Space>', '<NOP>')

-- * then cgn multi-cursor (TODO Remap not working)
-- local function customAsterisk()
--   vim.api.nvim_command([[keepjumps normal! mi*`i]])
--   print('asterisk remapped')
-- end
-- vim.api.nvim_set_keymap('n', '*', ':keepjumps normal! mi*`i<CR>' ,{noremap = true, silent = true, desc= "Use start without jumping to next word or adding to jump list"})


keymap('n', '<leader>W', ':WhichKey<cr>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- oil
keymap("n", "-", ':lua require("oil").open()<cr>', { desc = "Open parent directory" })
keymap("n", "_", ':lua require("oil").close()<cr>', { desc = "Close parent directory" })

-- Allow gf to open non-existent files
keymap('n', 'gf', ':edit <cfile><CR>', {desc = 'Open filename under cursor'})

-- better window movement
keymap('n', '<C-h>', '<C-w>h', {desc = 'Switch window left'})
keymap('n', '<C-j>', '<C-w>j', {desc = 'Switch window down'})
keymap('n', '<C-k>', '<C-w>k', {desc = 'Swith window up'})
keymap('n', '<C-l>', '<C-w>l', {desc = 'Switch window right'})

-- Clear search
vim.api.nvim_create_user_command('C', 'let @/=""', {})

-- Delte white space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Commenting code
-- Vgc and gci{

-- Copy and paste
keymap('v', '<C-c>', '"+yi', { silent = true })
keymap('v', '<C-x>', '"+c', { silent = true })
keymap('v', '<C-v>', 'c<ESC>"+p', { silent = true })
keymap('v', '<C-V>', '<ESC>"+pa', { silent = true })

-- Neoclip
keymap('n', '<leader>cm', ':Telescope neoclip<CR>', {desc = 'Telescope neoclip'})

-- Better indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')


-- Move while insert mode
keymap('i', '<C-l>', '<Right>')
keymap('i', '<C-h>', '<Left>')
keymap('i', '<C-j>', '<Down>')
keymap('i', '<C-k>', '<Up>')

-- Moving to start or end of line (insert mode)
-- <C-o> switches vim to insert mode for one command
keymap('i', t'<C-e>', '<C-o>$')
keymap('i', t'<C-a>', '<C-o>0')

-- Scroll
keymap('n', '<S-left>', '10zh')
keymap('n', '<S-right>', '10zl')

-- Move selected block in visual mode
keymap('x', 'K', ':move \'<-2<CR>gv-gv')
keymap('x', 'J', ':move \'>+1<CR>gv-gv')

-- Tab switch buffer
keymap('n', '<S-l>', ':bnext<CR>') -- :BufferLineCycleNext
keymap('n', '<S-h>', ':bprevious<CR>') -- :BufferLineCyclePrev
keymap('n', '<C-w>', ':BufferLineCloseOthers<CR>')
keymap('n', '<C-p>', ':BufferLinePick<CR>', {desc = 'Buffer pick'})
map('n', '<leader>Bl', ':BufferLineCloseLeft<CR>', {desc = 'Buffer close left'})
map('n', '<leader>Br', ':BufferLineCloseRight<CR>', {desc = 'Buffer close right'})

-- resize with arrows
keymap('n', '<C-Up>', ':resize +2<cr>')
keymap('n', '<C-Down>', ':resize -2<cr>')
keymap('n', '<C-Left>', ':vertical resize -2<cr>')
keymap('n', '<C-Right>', ':vertical resize +2<cr>')

-- Rest
keymap("n", "<LocalLeader>rr", ":RestNvim<cr>", {desc = 'Rest run'})
keymap("n", "<LocalLeader>rp", ":RestNvimPreview<cr>", {desc = 'Rest preview'})
keymap("n", "<LocalLeader>rl", ":RestNvimLast<cr>", {desc = 'Rest run last'})


-- toggleterm
keymap('n', '<LocalLeader>th', ':ToggleTerm size=20 direction=horizontal<CR>', {desc = 'Terminal horizontal'})
keymap('n', '<LocalLeader>tV', ':ToggleTerm size=110 direction=vertical<CR>', {desc = 'Terminal vertical'})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]])
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead of term://*
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

-- nv-nvim-tree
keymap('n', '<leader>nr', ':NvimTreeRefresh<CR>', {desc = 'Tree refresh'})
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {desc = 'Tree togle'})
keymap('n', '<leader>nf', ':NvimTreeFindFile<CR>', {desc = 'Tree find file'})

-- dap debugging
map('n', '<leader>dn', ":lua require('osv').launch({port = 5677})<CR>", {desc = "Debug Neovim-kind"})
map('n', '<F5>', ":lua require('dap').continue()<CR>", {desc = 'Debug continue'})

map('n', '<F11>', ":lua require('dap').step_into()<CR>", {desc = 'Debug step into'})
map('n', '<F10>', ":lua require('dap').step_over()<CR>", {desc = 'Debug step over'})
map('n', '<S-F12>', ":lua require('dap').step_out()<CR>", {desc = 'Debug step out'})

map('n',  '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>", {desc = 'Debug toggle breakpoint'})
map('n', '<leader>dr', ":lua require'dap'.restart()<cr>", {desc = 'Debug restart'})
map('n', '<leader>ds', ":lua require'dap'.stop()<cr>", {desc = 'Debug stop'})
map('n', '<leader>dT', ":lua require'dap'.terminate()<cr>", {desc = 'Debug terminate'})
map('n',  '<leader>dC', ":lua require'dap'.close()<CR>", {desc = 'Debug close'})
map('n',  '<leader>dc', ":lua require'dap'.continue()<CR>", {desc = 'Debug continue'})
map('n',  '<leader>dU', ":lua require'dap'.up()<CR>", {desc = 'Debug up'})
map('n',  '<leader>dD', ":lua require'dap'.down()<CR>", {desc = 'Debug down'})
map('n',  '<leader>d_', ":lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>", {desc = 'Debug stop run last'})

map('n',  '<leader>dR', ":lua require'dap'.repl.toggle({}, 'vsplit')<CR><C-w>l", {desc = 'Debug toggle REPL'})
map('n', '<Leader>dro', ":lua require('dap').repl.open()<CR>", {desc = 'Debug open REPL'})
map('n', '<Leader>drl', ":lua require('dap').repl.run_last()<CR>", {desc = 'Debug run last REPL'})


map('n',  '<leader>de', ":lua require'dap'.set_exception_breakpoints({'all'})<CR>", {desc = 'Debug execution breakpoint'})
map('n', '<Leader>dbc', ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {desc = 'Debug condition breakpoint'})
map('n', '<Leader>dbm', ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>", {desc = 'Debug breakpoint with message'})
map('n',  '<leader>da', ":lua require'debugHelper'.attach()<CR>", {desc = 'Debug attach'})
map('n',  '<leader>dA', ":lua require'debugHelper'.attachToRemote()<CR>", {desc = 'Debug attach remote'})

-- dap-ui
map('n',  '<leader>dh', ":lua require'dap.ui.variables'.hover()<CR>", {desc = 'Debug ui hover'})
map('v',  '<leader>dv', ":lua require'dap.ui.variables'.visual_hover()<CR>", {desc = 'Debug ui visual hover'})
map('n',  '<leader>d?', ":lua require'dap.ui.variables'.scopes()<CR>", {desc = 'Debug scopes'})
map('n', '<leader>dui', ":lua require('dapui').toggle()<CR>", {desc = 'Debug ui toggle'})
map('n', '<leader>duh', "<cmd>lua require'dap.ui.widgets'.hover()<CR>", {desc = 'Debug ui widget hover'})
map('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", {desc = 'Debug widgets and scope'})
map('n', '<F4>', ":lua require('dapui').toggle()<CR>", {desc = 'Debug ui toggle'})

-- symbols
keymap('n', '<LocalLeader>s', ":SymbolsOutline<cr>", {desc = 'Symbols outline'})

-- change list
map('n', '<leader>cl', ":changes<CR>", {desc = 'Change list'})

-- marks https://github.com/chentoast/marks.nvim
map('n', 'mm', ":lua require('marks').set_next()<CR>", {desc = 'Marks set'})
map('n', 'mn', ":lua require('marks').next()<CR>", {desc = 'Marks next'})
map('n', 'ml', ":MarksListAll<CR>", {desc = 'Marks list'})
map('n', 'm-', ":lua require('marks').delete_buf()<CR>", {desc = 'Marks delete buffer'})
map("n", "<leader>ml", ":Telescope marks<CR>", {desc = 'Marks telescope'})

-- telescope-dap
map('n', '<leader>dtf', ":Telescope dap frames<CR>", {desc = 'Telescope dap frames'})
map('n', '<leader>dtc', ":Telescope dap commands<CR>", {desc = 'Telescope dap commands'})
map('n', '<leader>dto', ":Telescope dap configurations<CR>", {desc = 'Telescope dap configuration'})
map('n', '<leader>dlb', ":Telescope dap list_breakpoints<CR>", {desc = 'Telescope dap breakpoints'})
map('n', '<leader>dv', ":Telescope dap variables<CR>", {desc = 'Telescope dap variables'})

-- Telescope -- See `:help telescope.builtin`
-- navigate preview window with ctl-d ctl-u
vim.keymap.set("n", "<Leader>ff", ":lua require('telescope.builtin').find_files()<CR>", { desc = '[f]ind [f]iles' })
--vim.keymap.set("n", "<Leader>fF", ":lua require('telescope.builtin').find_files({})<CR>", { desc = '[f]ind [f]iles Exact Name' })
map("n", "<Leader>fb", ':lua require("telescope").extensions.file_browser.file_browser()<CR>', {desc = 'Telescope extensions file browse'})
map("n", "<Leader>fC", ":lua require('telescope.builtin').colorscheme()<CR>")
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map("n", "<Leader>fc", ":Telescope commands<CR>", {desc = 'Telescope commands'})
map("n", "<Leader>jl", ":Telescope jumplist<CR>", {desc = 'Telescope jumplist'})
map("n", "<Leader>fq", ":Telescope quickfix<CR>", {desc = 'Telescope quickfix'})
map("n", "<Leader>fh", ":Telescope quickfixhistory<CR>", {desc = 'Telescope quick history'})
map("n", "<Leader>fg", ":Telescope live_grep<CR>", {desc = 'Telescope live grep'})
map("n", "<Leader>fr", ":Telescope resume<CR>", {desc = 'Telescope resume'})
map("n", "<Leader>go", ":lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", {desc = 'Telescope grep open files'})
map("n", "<Leader>fp", ":Telescope projects<CR>", {desc = 'Telescope projects'})
map("n", "<Leader>gs", ":Telescope git_status<CR>", {desc = 'Telescope git status'})
map("n", "<Leader>gf", ":Telescope git_files<CR>", {desc = 'Telescope git files'})
map("n", "<Leader>gc", ":lua require('telescope.builtin').git_commits({ git_command = {'git', 'log', '--pretty=reference'} })<cr>", {desc = 'Telescope git commits'})
map("n", "<Leader>gt", ":Telescope git_stash<CR>", {desc = 'Telescope git stash'})
map("n", "<Leader>gb", ":Telescope git_branches<CR>", {desc = 'Telescope git branches'})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })


-- git
--vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
keymap('n', "<leader>gl", ":LazyGit<CR>", {desc = 'Lazy git'})
keymap('n', '<leader>DL', ':diffget local<CR>', {desc = 'Git diffget local'})
keymap('n', '<leader>DB', ':diffget base<CR>', {desc = 'Git diffget base'})
keymap('n', '<leader>DR', ':diffget remote<CR>', {desc = 'Git diffget remote'})
map("n", "<LocalLeader>gb", ":GitSigns blame_line<cr>", {desc = "Git Blame"})

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

vim.keymap.set("n", "<LocalLeader>ff", function() builtin.find_files({ cwd = utils.buffer_dir() }) end,
  {desc = "Find files in cwd"})
vim.keymap.set('n', '<LocalLeader>fu', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- Spring
local spring_run_mvn = 'mvn spring-boot:run -Dspring-boot.run.properties=local'
local command = ':lua require("toggleterm").exec("' .. spring_run_mvn .. '")<CR>'
keymap('n', '<leader>sr', command)
keymap('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
keymap('n', '<leader>jc', ':lua require("jdtls").compile("incremental")')

-- neotest
map("n", "<leader>tr", ':lua require("neotest").run.run()<CR>', {desc = 'Test run under cursor'})
map("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {desc = 'Test run file'})
map("n", "<leader>td", ':lua require("neotest").run.run({strategy = "dap"})<CR>', {desc = 'Test debug'})
map("n", "<leader>ts", ':lua require("neotest").run.stop()<CR>', {desc = 'Test stop'})
map("n", "<leader>ta", ':lua require("neotest").run.attach()<CR>', {desc = 'Test attach'})
map("n", "<leader>tt", ':lua require("neotest").summary.toggle()<CR>', {desc = 'Test toggle summary'})
map("n", "<leader>to", ':lua require("neotest").output.open()<CR>', {desc = 'Test toggle summary output'})
map("n", "<leader>tp", ':lua require("neotest").output_panel.toggle()<CR>', {desc = 'Test toggle output panel'})
map("n", "<leader>tw", ':lua require("neotest").watch.toggle()<CR>', {desc = 'Test toggle watch'})

-- trouble
map("n", "<leader>xx", ":lua require('trouble').toggle()<cr>", {desc = 'Toggle trouble'})
map("n", "<leader>xw", ":lua require('trouble').toggle('workspace_diagnostics')<cr>", {desc = 'Trouble toggle workspace'})
map("n", "<leader>xd", ":lua require('trouble').toggle('document_diagnostics')<cr>", {desc = 'Trouble toggle document'})
map("n", "<leader>xq", ":lua require('trouble').toggle('quickfix')<cr>", {desc = 'Trouble toggle quickfix'})
map("n", "<leader>xl", ":lua require('trouble').toggle('loclist')<cr>", {desc = 'Trouble toggle loclist'})
map("n", "<leader>xr", ":lua require('trouble').toggle('lsp_references')<cr>", {desc = 'Trouble toggle references'})

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
