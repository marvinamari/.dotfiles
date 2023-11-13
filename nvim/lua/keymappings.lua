-- Escape termcodes
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local keymap = require 'utils'.keymap
local opts = { noremap=true, silent=true }

vim.g.maplocalleader = '\\'
keymap('n', '<Space>', '<NOP>', opts)

-- Go to previous location Ctrl + o
-- Go to next location Ctrl + i

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- oil
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "_", require("oil").close, { desc = "Close parent directory" })

-- Allow gf to open non-existent files
keymap('', 'gf', ':edit <cfile><CR>', {})

-- better window movement
keymap('n', '<C-h>', '<C-w>h', {silent = true})
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Clear search
vim.api.nvim_create_user_command('C', 'let @/=""', {})

-- Delte white space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

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
keymap('n', '<S-left>', '20zh', opts)
keymap('n', '<S-right>', '20zl', opts)

-- Move selected block in visual mode
keymap('x', 'K', ':move \'<-2<CR>gv-gv', opts)
keymap('x', 'J', ':move \'>+1<CR>gv-gv', opts)

-- Tab switch buffer
keymap('n', '<S-l>', ':bnext<CR>', opts) -- :BufferLineCycleNext
keymap('n', '<S-h>', ':bprevious<CR>', opts) -- :BufferLineCyclePrev
keymap('n', '<C-w>', ':BufferLinePickClose<CR>', opts)
keymap('n', '<LocalLeader>b', ':BufferLinePick<CR>', opts)

-- Replace word under cursor and press to repeat operation, n to skip
-- keymap('n', 's*', ":let @/='<'.expand('<cword>').'>'<CR>cgn", opts)
-- keymap('x', 's*', 'sy:let @/=@s<CR>cgn', opts)
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
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<cr>', opts)
keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<cr>', opts)

keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', opts)
keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', opts)
keymap('n', 'gr', ":lua require('telescope.builtin').lsp_references()<cr>", opts )
keymap('n', 'gR', ":lua vim.lsp.buf.references()<cr>", opts )
keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>', opts)
keymap('n', '<leader>D', ':lua vim.lsp.buf.type_definition()<cr>', opts)
keymap('n', '<leader>ds', ":lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
keymap('n', '<leader>ws', ":lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", opts)

-- See `:help K` for why this keymap
keymap('n', 'gh', ':lua vim.lsp.buf.hover()<cr>', opts)
keymap('n', 'gs', ':lua vim.lsp.buf.signature_help()<cr>', opts)
keymap('n', '<leader>F', ':lua vim.lsp.buf.format()<cr>', opts)

-- Lesser used LSP functionality
keymap('n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
keymap('n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
-- keymap('n', '<leader>wl', function()
--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, '[W]orkspace [L]ist Folders')

--Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Rest
keymap("n", "<LocalLeader>hr", ":RestNvim<cr>", opts)
keymap("n", "<LocalLeader>hp", ":RestNvimPreview<cr>", opts)
keymap("n", "<LocalLeader>hl", ":RestNvimLast<cr>", opts)


-- toggleterm
keymap('n', '<leader>tT', ':ToggleTerm size=20 direction=horizontal<CR>', opts)
keymap('n', '<leader>tV', ':ToggleTerm size=110 direction=vertical<CR>', opts)
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  --vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  --vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  --vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  --vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead of term://*
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

-- nv-nvim-tree
keymap('n', '<leader>nr', ':NvimTreeRefresh<CR>', opts)
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap('n', '<leader>nf', ':NvimTreeFindFile<CR>', opts)

-- git
--vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
keymap('n', "<leader>lg", ":LazyGit<CR>", opts)
keymap('n', '<leader>DL', ':diffget local<CR>', opts)
keymap('n', '<leader>DB', ':diffget base<CR>', opts)
keymap('n', '<leader>DR', ':diffget remote<CR>', opts)

--comment
vim.keymap.set('n', '<C-/>', 'gcc', { remap = true })
keymap('n', '<C-.>', 'gbc', opts)

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

-- symbols
keymap('n', '<LocalLeader>s', ":SymbolsOutline<cr>", opts)

-- change list
map('n', '<leader>cl', ":changes<CR>", opts)

-- marks
map('n', 'mm', ':lua require("harpoon.mark").add_file()<cr>', opts)
map('n', 'm<space>', ":lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)

-- telescope-dap
map('n', '<leader>dtf', ":Telescope dap frames<CR>")
map('n', '<leader>dtc', ":Telescope dap commands<CR>")
map('n', '<leader>dto', ":Telescope dap configurations<CR>")
map('n', '<leader>dlb', ":Telescope dap list_breakpoints<CR>")
map('n', '<leader>dv', ":Telescope dap variables<CR>")

-- Telescope -- See `:help telescope.builtin`
vim.keymap.set("n", "<Leader>ff", ":lua require('telescope.builtin').find_files()<CR>", { desc = '[f]ind [f]iles' })
map("n", "<Leader>fb", ':lua require("telescope").extensions.file_browser.file_browser()<CR>')
map("n", "<Leader>fC", ":lua require('telescope.builtin').colorscheme()<CR>")
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map("n", "<Leader>fc", ":Telescope commands<CR>")
map("n", "<Leader>fj", ":Telescope jumplist<CR>")
map("n", "<Leader>fq", ":Telescope quickfix<CR>")
map("n", "<Leader>fh", ":Telescope quickfixhistory<CR>")
map("n", "<Leader>fg", ":Telescope live_grep<CR>")
map("n", "<Leader>fr", ":Telescope resume<CR>")
map("n", "<Leader>go", ":lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>")
map("n", "<Leader>fm", ":Telescope marks<CR>")
map("n", "<Leader>fp", ":Telescope projects<CR>")
map("n", "<Leader>gs", ":Telescope git_status<CR>")
map("n", "<Leader>gf", ":Telescope git_files<CR>")
map("n", "<Leader>gc", ":Telescope git_commits<CR>")
map("n", "<Leader>gt", ":Telescope git_stash<CR>")
map("n", "<Leader>gb", ":Telescope git_branches<CR>")

vim.keymap.set("n", "<LocalLeader>f", function() builtin.find_files({ cwd = utils.buffer_dir() }) end,
  {desc = "Find files in cwd"})
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

-- Spring
local spring_run_mvn = 'mvn spring-boot:run -Dspring-boot.run.properties=local'
local command = ':lua require("toggleterm").exec("' .. spring_run_mvn .. '")<CR>'
keymap('n', '<leader>sr', command, opts)
keymap('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>', opts)
keymap('n', '<leader>jc', ':lua require("jdtls").compile("incremental")', opts)

-- neotest
map("n", "<leader>tr", ':lua require("neotest").run.run()<CR>')
map("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
map("n", "<leader>td", ':lua require("neotest").run.run({strategy = "dap"})<CR>', opts)
map("n", "<leader>ts", ':lua require("neotest").run.stop()<CR>', opts)
map("n", "<leader>ta", ':lua require("neotest").run.attach()<CR>', opts)
map("n", "<leader>tt", ':lua require("neotest").summary.toggle()<CR>', opts)
map("n", "<leader>to", ':lua require("neotest").summary.output()<CR>', opts)
map("n", "<leader>tp", ':lua require("neotest").output_panel.toggle()<CR>', opts)
map("n", "<leader>tw", ':lua require("neotest").watch.toggle()<CR>', opts)

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

-- Register keymaps with which-key
local wk = require("which-key")
wk.register({
  f = {
    name = "Find Files In Buffer"
  },
  h = { name = "Rest Requests",
    r = {":RestNvim<cr>", "Run request under cursor"},
    p = {":RestNvimPreview<cr>", "Preview request Curl command"},
    l = {":RestNvimLast<cr>", "Re-run last request"},
  },
}, { prefix = "<LocalLeader>" })
