--https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b
require('utils')
local dap = require('dap')

require('telescope').load_extension('dap')
require('nvim-dap-virtual-text').setup()
require('dapui').setup({
  -- icons = { expanded = '?', collapsed = '?' },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with 'id' and 'size' keys
      { id = 'scopes', size = 0.25 },
      { id = 'breakpoints', size = 0.20 },
      { id = 'stacks', size = 0.25 },
      { id = 'watches', size = 0.30 },
    },
    size = 50,  -- Width
    position = 'right', -- Can be 'left', 'right', 'top', 'bottom'
  },
  tray = {
    elements = { 'repl' },
    size = 10,
    position = 'bottom', -- Can be 'left', 'right', 'top', 'bottom'
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { 'q', '<Esc>' },
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

