-- echo v:lua.vim.uv.os_name().sysname -- lua print(vim.uv.os_uname().sysname)
-- Go to previous location Ctrl + o
-- Go to next location Ctrl + i
-- Go to next method, change, diagnostic [] m|c|d
-- Increment Decrement number Ctrl-A Ctrl-X
-- substitue in block <,>s/old/new/g
-- jump to matching brace %
--

-- variables
local keymap = require 'utils'.keymap

-- Escape termcodes
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- set pwd with cd %%
vim.keymap.set('c', '%%', function()
  if (vim.fn.getcmdtype() == ':') then
    return vim.fn.expand('%:h')..'/'
  else
    return '%%'
  end
end
, {expr = true})

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

-- Commenting code
-- Vgc and gci{

-- Copy and paste
keymap('v', '<C-c>', '"+yi', { silent = true })
keymap('v', '<C-x>', '"+c', { silent = true })
keymap('v', '<C-v>', 'c<ESC>"+p', { silent = true })
keymap('v', '<C-V>', '<ESC>"+pa', { silent = true })

-- Chat normal mode
-- map('n', "<leader>cc", "<cmd>ChatGPT<CR>", {desc = "ChatGPT Toggle"})
-- map('n', "<leader>CC", "<cmd>ChatGPTCompleteCode<CR>", {desc = "ChatGPT Complete Code"})
-- map('n', "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>", {desc = "Chat grammer correction"})
-- map('n', "<leader>ct", "<cmd>ChatGPTRun translate<CR>", {desc = "Chat translate"})
-- map('n', "<leader>ck", "<cmd>ChatGPTRun keywords<CR>", {desc = "Chat keywords"})
-- map('n', "<leader>cd", "<cmd>ChatGPTRun docstring<CR>", {desc = "Chat docstring"})
-- map('n', "<leader>ca", "<cmd>ChatGPTRun add_tests<CR>", {desc = "Chat add tests"})
-- map('n', "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>", {desc = "Chat optimize code"})
-- map('n', "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", {desc = "Chat summarize"})
-- map('n', "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>", {desc = "Chat fix bugs"})
-- map('n', "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>", {desc = "Chat explain code"})
-- map('n', "<leader>cr", "<cmd>ChatGPTRun roxygen_edit<CR>", {desc = "Chat roxygen_edit"})
-- map('n', "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", {desc = "Chat code readability analysis"})
--
-- -- Chat visual mode
-- map('v', "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>", {desc = "Chat Edit with instruction"})
-- map('v', "<leader>ct", "<cmd>ChatGPTRun translate<CR>", {desc = "Chat translate"})
-- map('v', "<leader>ck", "<cmd>ChatGPTRun keywords<CR>", {desc = "Chat keywords"})
-- map('v', "<leader>cd", "<cmd>ChatGPTRun docstring<CR>", {desc = "Chat docstring"})
-- map('v', "<leader>ca", "<cmd>ChatGPTRun add_tests<CR>", {desc = "Chat add tests"})
-- map('v', "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>", {desc = "Chat optimize code"})
-- map('v', "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", {desc = "Chat summarize"})
-- map('v', "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>", {desc = "Chat fix bugs"})
-- map('v', "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>", {desc = "Chat explain code"})
-- map('v', "<leader>cr", "<cmd>ChatGPTRun roxygen_edit<CR>", {desc = "Chat roxygen_edit"})
-- map('v', "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", {desc = "Chat code readability analysis"})

-- Copilot
map('n', "<leader>cc", "<cmd>CopilotChatToggle<CR>", {desc = "Copilot Chat Toggle"})
map('v', "<leader>cf", "<cmd>CopilotChatFix<CR>", {desc = "Copilot Chat Fix"})
map('v', "<leader>co", "<cmd>CopilotChatOptimize<CR>", {desc = "Copilot Chat Optimize"})
map('v', "<leader>ce", "<cmd>CopilotCharExplain<CR>", {desc = "Copilot Chat Explain"})
map('v', "<leader>ct", "<cmd>CopilotChatTests<CR>", {desc = "Copilot Chat Tests"})
map('v', "<leader>cr", "<cmd>CopilotChatReview<CR>", {desc = "Copilot Chat Review"})

map('n', "<leader>ca", "<cmd>Copilot auth<CR>", {desc = "Copilot auth"})

-- Dbee 
map('n', "<LocalLeader>do", "<cmd>lua require('dbee').open()<CR>", {desc = "Dbee Open"})
map('n', "<LocalLeader>dc", "<cmd>lua require('dbee').close()<CR>", {desc = "Dbee Close"})
map('n', "<LocalLeader>dd", "<cmd>lua require('dbee').toggle()<CR>", {desc = "Dbee Toggle"})

map('n', "<leader>cs", "<cmd>Copilot suggestions<CR>", {desc = "Copilot suggestions"})

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
keymap('n', '<leader>Bq', ':BufferLineCloseOthers<CR>')
keymap('n', '<leader>Bp', ':BufferLinePick<CR>', {desc = 'Buffer pick'})
map('n', '<leader>Bc', ':BufferLinePickClose<CR>', {desc = 'Buffer Pick close'})
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
keymap('n', '<leader>nR', ':NvimTreeRefresh<CR>', {desc = 'Tree refresh'})
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {desc = 'Tree togle'})
keymap('n', '<leader>nF', ':NvimTreeFindFile<CR>', {desc = 'Tree find file'})

-- neogen
map('n', "<leader>nc", ":lua require('neogen').generate({type = 'class'})<CR>", {desc = "Neogen Generate Class"})
map('n', "<leader>nf", ":lua require('neogen').generate({type = 'func'})<CR>", {desc = "Neogen Generate Func"})
map('n', "<leader>nt", ":lua require('neogen').generate({type = 'type'})<CR>", {desc = "Neogen Generate Type"})

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
keymap('n', '<LocalLeader>s', ":Outline<cr>", {desc = 'Symbols outline'})

-- change list
map('n', '<leader>Cl', ":changes<CR>", {desc = 'Change list'})

-- quickfix list
map('n', "<leader>qfo", "<cmd>copen<CR>", {desc = "Quickfix open"} )
map('n', "<leader>qfc", "<cmd>cclose<CR>", {desc = "Quickfix close"} )
map('n', "<leader>qfd", "<cmd>cexpr []<CR>", {desc = "Quickfix delete"})

-- marks https://github.com/chentoast/marks.nvim
map('n', 'mm', ":lua require('marks').set_next()<CR>", {desc = 'Marks set'})
map('n', 'mn', ":lua require('marks').next()<CR>", {desc = 'Marks next'})
map('n', 'ml', ":MarksListAll<CR>", {desc = 'Marks list'})
map('n', 'm-', ":lua require('marks').delete_buf()<CR>", {desc = 'Marks delete buffer'})
map("n", "<leader>ml", ":Telescope marks<CR>", {desc = 'Marks telescope'})

-- fzf-lua
map('n', "<LocalLeader>ff", ":lua require('fzf-lua').files()<CR>", {desc = "Fzf Files"})
map('n', "<LocalLeader>fr", ":lua require('fzf-lua').resume()<CR>", {desc = "Fzf Resume"})
map('n', "<LocalLeader>fg", ":lua require('fzf-lua').grep_project()<CR>", {desc = "Fzf Grep"})
map('n', "<LocalLeader>fG", ":lua require('fzf-lua').live_grep_glob()<CR>", {desc = "Fzf rg --glob"})
map('n', "<LocalLeader>fl", ":lua require('fzf-lua').live_grep()<CR>", {desc = "Fzf Live Grep Current Project"})
map('n', "<LocalLeader>fc", ":lua require('fzf-lua').lgrep_curbuf()<CR>", {desc = "Fzf Live Grep Current Buffer"})
map('n', "<LocalLeader>fu", ":lua require('fzf-lua').grep_cword()<CR>", {desc = "Fzf Grep Word Under Cursor"})

-- telescope-dap
map('n', '<leader>dtf', ":Telescope dap frames<CR>", {desc = 'Telescope dap frames'})
map('n', '<leader>dtc', ":Telescope dap commands<CR>", {desc = 'Telescope dap commands'})
map('n', '<leader>dto', ":Telescope dap configurations<CR>", {desc = 'Telescope dap configuration'})
map('n', '<leader>dlb', ":Telescope dap list_breakpoints<CR>", {desc = 'Telescope dap breakpoints'})
map('n', '<leader>dv', ":Telescope dap variables<CR>", {desc = 'Telescope dap variables'})

-- Telescope -- See `:help telescope.builtin`
-- navigate preview window with ctl-d ctl-u
vim.keymap.set("n", "<Leader>ff", ":lua require('telescope.builtin').find_files()<CR>", { desc = '[f]ind [f]iles' })
map('n', "<Leader>fi", "<cmd>lua require('telescope.builtin').find_files({find_command= {'rg','--no-ignore','--hidden','--files','-g','!**/node_modules/*','-g','!**/.git/*'},})", { desc = "Find ignored files"})
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
map('n', "<leader>lg", ":LazyGit<CR>", {desc = 'Lazy git'})
map('n', '<leader>DL', ':diffget local<CR>', {desc = 'Git diffget local'})
map('n', '<leader>DB', ':diffget base<CR>', {desc = 'Git diffget base'})
map('n', '<leader>DR', ':diffget remote<CR>', {desc = 'Git diffget remote'})
map("n", "<LocalLeader>gb", ":GitSigns blame_line<cr>", {desc = "Git Blame"})
-- Merge conflicts
vim.keymap.set("n", "<leader>1", ":diffget LOCAL<CR>",  { desc = "mergetool mapping" })
vim.keymap.set("n", "<leader>2", ":diffget BASE<CR>",   { desc = "mergetool mapping" })
vim.keymap.set("n", "<leader>3", ":diffget REMOTE<CR>", { desc = "mergetool mapping" })

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

vim.keymap.set("n", "<LocalLeader>fh", function() builtin.find_files({ cwd = utils.buffer_dir() }) end,
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
map('n', '<leader>sr', command)
map('n', '<leader>jtc', ':lua require("java").test.run_current_class()<CR>', {desc = "Java test class"})
map('n', '<leader>jtd', ':lua require("java").test.debug_current_class()<CR>', {desc = "Java Debug Test Class"})
map('n', '<leader>jtm', ':lua require("java").test.run_current_method()<CR>', {desc = "Java Test Method"})
map('n', "<leader>jtv", ":lua require('java').test.view_last_report()<CR>", {desc = "Java Test View"})

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
