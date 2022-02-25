--https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b
require('utils')
local dap = require('dap')

require('telescope').load_extension('dap')
require('config.nvimdap.python')
require('nvim-dap-virtual-text').setup()
require("dapui").setup({
  -- icons = { expanded = "?", collapsed = "?" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      { id = "scopes", size = 0.25 },
      { id = "breakpoints", size = 0.20 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 0.30 },
    },
    size = 50,  -- Width
    position = "right", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

-- nvim-dap-virtual-text. Show virtual text for current frame
vim.g.dap_virtual_text = true

-- require('dap').set_log_level('INFO')
dap.defaults.fallback.terminal_win_cmd = '80vsplit new'
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})


map('n',  '<leader>dh', ":lua require'dap'.toggle_breakpoint()<CR>")
map('n',  '<S-F11>',      ":lua require'dap'.step_out()<CR>")
map('n',  '<F11>',      ":lua require'dap'.step_into()<CR>")
map('n',  '<F10>',      ":lua require'dap'.step_over()<CR>")
map('n',  '<leader>ds', ":lua require'dap'.stop()<CR>")
map('n',  '<leader>dn', ":lua require'dap'.continue()<CR>")
map('n',  '<leader>dk', ":lua require'dap'.up()<CR>")
map('n',  '<leader>dj', ":lua require'dap'.down()<CR>")
map('n',  '<leader>d_', ":lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>")
map('n',  '<leader>dih', ":lua require'dap.ui.variables'.hover()<CR>")
map('n',  '<leader>dr', ":lua require'dap'.repl.toggle({}, 'vsplit')<CR><C-w>l")
map('v',  '<leader>di', ":lua require'dap.ui.variables'.visual_hover()<CR>")
map('n',  '<leader>d?', ":lua require'dap.ui.variables'.scopes()<CR>")
map('n',  '<leader>de', ":lua require'dap'.set_exception_breakpoints({'all'})<CR>")
--map('n',  '<leader>da', ":lua require'debugHelper'.attach()<CR>")
--map('n',  '<leader>dA', ":lua require'debugHelper'.attachToRemote()<CR>")
map('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
-- nvim-dap-ui
map('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>')

-- telescope-dap
map('n', '<leader>df', ':Telescope dap frames<CR>')
map('n', '<leader>dcc', ':Telescope dap commands<CR>')
map('n', '<leader>dco', ':Telescope dap configurations<CR>')
map('n', '<leader>dlb', ':Telescope dap list_breakpoints<CR>')
map('n', '<leader>dv', ':Telescope dap variables<CR>')
