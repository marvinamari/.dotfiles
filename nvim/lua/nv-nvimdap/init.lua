local dap = require('dap')
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
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
        return '/usr/bin/python'
      end
    end;
  },
}

-- key bindings
-- mfussenegger/nvim-dap
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/apps/vscode-node-debug2/out/src/nodeDebug.js'},
}
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

--vim.api.nvim_set_keymap( 'n',  '<leader>dh', ":lua require'dap'.toggle_breakpoint()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<S-k>',      ":lua require'dap'.step_out()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<S-l>',      ":lua require'dap'.step_into()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<S-j>',      ":lua require'dap'.step_over()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>ds', ":lua require'dap'.stop()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>dn', ":lua require'dap'.continue()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>dk', ":lua require'dap'.up()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>dj', ":lua require'dap'.down()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>d_', ":lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>di', ":lua require'dap.ui.variables'.hover()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>dr', ":lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l", {noremap = true})
--vim.api.nvim_set_keymap( 'v',  '<leader>di', ":lua require'dap.ui.variables'.visual_hover()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>d?', ":lua require'dap.ui.variables'.scopes()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>de', ":lua require'dap'.set_exception_breakpoints({'all'})<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>da', ":lua require'debugHelper'.attach()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>dA', ":lua require'debugHelper'.attachToRemote()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>di', ":lua require'dap.ui.widgets'.hover()<CR>", {noremap = true})
--vim.api.nvim_set_keymap( 'n',  '<leader>d?', ":lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", {noremap = true})

-- Plug 'nvim-telescope/telescope-dap.nvim'
require('telescope').setup()
require('telescope').load_extension('dap')
--vim.api.nvim_set_keymap( 'n', '<leader>df', ':Telescope dap frames<CR>', { noremap = true})
--vim.api.nvim_set_keymap( 'n', '<leader>dc', ':Telescope dap commands<CR>', { noremap = true})
--vim.api.nvim_set_keymap( 'n', '<leader>db', ':Telescope dap list_breakpoints<CR>', { noremap = true})

-- theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
vim.g.dap_virtual_text = 'v:true'

-- Plug 'rcarriga/nvim-dap-ui'
-- lua require("dapui").setup()
-- nnoremap <leader>dq :lua require("dapui").toggle()<CR>
