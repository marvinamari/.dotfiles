--https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b
require('utils')
local dap = require('dap')
local home = vim.fn.has('unix') and os.getenv('HOME') or os.getenv('USERPROFILE')
local api = vim.api
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

-- Lua one step mankind plugin
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
  }
}

dap.adapters.nlua = function(callback, conf)
  local adapter = {
    type = 'server',
    host = '127.0.0.1',
    port = conf.port
  }
  if conf.start_neovim then
    local start_opts = conf.start_neovim
    conf.start_neovim = nil
    local handle
    local pid_or_err
    local opts = {
      args = {
        '-e',
        vim.v.progpath,
        '-c',
        string.format("lua require('osv').launch({ port = %s })", conf.port),
        start_opts.fname or api.nvim_buf_get_name(0),
      },
      cwd = start_opts.cwd or vim.fn.getcwd(),
      detached = true,
    }
    handle, pid_or_err = vim.loop.spawn('/usr/bin/alacritty', opts, function(code)
      handle:close()
      assert(code == 0, "Exit code must be 0, not " .. tostring(code))
    end)
    if not handle then
      error(pid_or_err)
    end
    local timer = vim.loop.new_timer()
    timer:start(1000, 0, function()
      timer:stop()
      timer:close()
      vim.schedule(function()
        callback(adapter)
      end)
    end)
  else
    callback(adapter)
  end
end

local lua_port = 5677
dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "New instance (current file)",
    port = lua_port,
    start_neovim = {}
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

-- Lua one step mankind plugin

--Python
dap.adapters.generic_remote = function(callback, config)
  callback({
    type = 'server',
    host = (config.connect or config).host or '127.0.0.1',
    port = (config.connect or config).port or '5678',
    options = {
      source_filetype = 'python'
    }
})
end
dap.configurations.python = {
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
dap.adapters.coreclr = {
  type = 'executable',
  command = home .. '/.local/share/nvim/mason/packages/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.adapters.coreclrattach = {
  type = 'executable',
  command = home .. '/.local/share/nvim/mason/packages/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode', '--attach'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll:', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
  {
    type = "coreclrattach",
    name = "attach - netcoredbg",
    request = "attach",
    program = function()
        return vim.fn.input('Path to dll:', vim.fn.getcwd() .. '/bin/Debug/', 'file')
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

