--https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b
require('utils')
local dap = require('dap')
local home = vim.fn.has('unix') and os.getenv('HOME') or os.getenv('USERPROFILE')
local api = vim.api
local isUnixOs = require 'utils'.isUnixOs
local configurations = dap.configurations
local adapters = dap.adapters

-- Lua one step mankind plugin
adapters.nlua = function(callback, config)
  callback({type = "server", host = config.host or "127.0.0.1", port = 5677}) --8086
end

adapters.local_lua = {
  type = "executable",
  command = "node",
  args = {
    home .. '/projects/local-lua-debugger-vscode/extension/debugAdapter.js'
  },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      -- 💀 If this is missing or wrong you'll see
      -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
      c.extensionPath = home .. "/projects/local-lua-debugger-vscode/"
      on_config(c)
    else
      on_config(config)
    end
  end,
}

local lua_port = 5677
configurations.lua = {
 {
    name = 'Current file (local-lua-dbg, lua)',
    type = 'local_lua',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = {
      lua = 'lua5.1',
      file = '${file}',
    },
    args = {},
  },
  {
    type = "nlua",
    request = "attach",
    port = lua_port,
    name = "Attach to running Neovim instance"
  },
  {
    type = "nlua",
    request = "attach",
    name = "New instance (dotfiles)",
    port = lua_port,
    start_neovim = {
      cwd = home .. '/dotfiles',
      fname = 'vim/.config/nvim/init.lua',
    }
  },
  {
    type = "nlua",
    request = "attach",
    name = "New instance (crate/crate)",
    port = lua_port,
    start_neovim = {
      cwd = home .. '/dev/crate/crate',
      fname = 'server/src/test/java/io/crate/planner/PlannerTest.java',
    }
  },
  {
    type = "nlua",
    request = "attach",
    name = "New instance (neovim/neovim)",
    port = lua_port,
    start_neovim = {
      cwd = home .. '/dev/neovim/neovim',
      fname = 'src/nvim/main.c',
    }
  },
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach',
    port = function()
      return assert(tonumber(vim.fn.input('Port: ')), 'Port is required')
    end
  },
}

-- Python
adapters.python = {
    type = 'executable';
    command = home .. '/.local/share/nvim/mason/packages/debugpy/venv/bin/python';
    args = { '-m', 'debugpy.adapter' };
}

adapters.generic_remote = function(callback, config)
  callback({
    type = 'server',
    host = (config.connect or config).host or '127.0.0.1',
    port = (config.connect or config).port or '5678',
    options = {
      source_filetype = 'python'
    }
})
end

configurations.python = {
  {
     type = 'python',
     request = 'launch',
     name = 'launch file',
     program = '${file}',
     pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
       return home .. '/.asdf/shims/python3'
      end
    end;
  },
  {
    type = "generic_remote",
    name = "Generic remote",
    request = "attach",
    justMyCode = false,
    connect = function()
      local host = vim.fn.input('Host [127.0.0.1]: ')
      host = host ~= '' and host or '127.0.0.1'
      local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
      return { host = host, port = port }
    end,
    pathMappings = {{
      localRoot = vim.fn.getcwd();
      remoteRoot = "/";
    }};
  }
}
--
-- DotNet
local exe = '/.local/share/nvim/mason/bin/netcoredbg' or '/AppData/Local/nvim-data/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe'

adapters.netcoredbg = {
  type = 'executable',
  command = home .. exe,
  args = {'--interpreter=vscode'}
}

adapters.netcoredbgattach = {
  type = 'executable',
  command = home .. exe,
  args = {'--interpreter=vscode', '--attach'}
}

configurations.cs = {
  {
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to executable:' .. vim.fn.getcwd() .. '- /bin/Debug/file')
    end,
  },
  {
    type = "netcoredbgattach",
    name = "attach - netcoredbg",
    request = "attach",
    program = function()
        return vim.fn.input('EnterProcess ID:')
    end,
  },
}
--

require('telescope').load_extension('dap')
require('nvim-dap-virtual-text').setup({})
require('dapui').setup({
  -- icons = { expanded = '?', collapsed = '?' },
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  force_buffers = true,
-- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
-- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
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
    border = 'single',
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
  render = {
      max_type_length = nil, -- Can be integer or nil.
      max_value_lines = 100, -- Can be integer or nil.
    }
})

-- nvim-dap-virtual-text. Show virtual text for current frame
vim.g.dap_virtual_text = true

-- require('dap').set_log_level('INFO')
dap.defaults.fallback.terminal_win_cmd = '80vsplit new'
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

