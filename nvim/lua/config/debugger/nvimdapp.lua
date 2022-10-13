--https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b
require('utils')
local dap = require('dap')
-- local configurations = dap.configurations
-- configurations.python = {{
--     type = 'python';
--     request = 'launch';
--     name = 'launch file';
--     program = '${file}';
--     pythonPath = function()
--       return '/Users/amari/.pyenv/shims/python3'
--     end
--   }}

--Python
dap.adapters.python = {
    type = 'executable';
    command = '/Users/amari/.local/share/nvim/mason/packages/debugpy/venv/bin/python';
    args = { '-m', 'debugpy.adapter'};
}
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = 'launch file';
    program = '${file}';
    pythonPath = function()
      return '/Users/amari/.pyenv/shims/python3'
    end
  }
}
--
-- DotNet
dap.adapters.coreclr = {
  type = 'executable',
  command = '/Users/amari/.local/share/nvim/mason/packages/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('/Users/amari/.local/share/nvim/mason/packages/', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
--

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
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
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

