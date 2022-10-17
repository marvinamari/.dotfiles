-- Mason path ~/.local/share/nvim/mason/bin
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Mason does not have an ensure installed option so we use this thirdparty plugin
local present, mason = pcall(require, "mason")

if not present then
  return
end

local options = {
  ensure_installed = {
     }, -- not an option from mason.nvim
  max_concurrent_installers = 10,
}

mason.setup(options)
require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {

    -- you can pin a tool to a particular version
    --{ 'golangci-lint', version = 'v1.47.0' },

    -- you can turn off/on auto_update per tool
    --{ 'bash-language-server', auto_update = true },

    "lua-language-server",
    "pyright",
    "black",
    "flake8",
    "debugpy",
    "prettier",
    "sqlfluff",
    "stylua",
    "typescript-language-server",
    --dap
    "js-debug-adapter"
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = false,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay
}

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MasonToolsUpdateCompleted',
    callback = function()
      vim.schedule(function()
        print 'mason-tool-installer has finished'
      end)
    end,
  })
