-- Mason path ~/.local/share/nvim/mason/bin

local pid = vim.fn.getpid()
local home = vim.fn.has('unix') and os.getenv('HOME') or os.getenv('USERPROFILE')
local root_pattern = require('lspconfig.util').root_pattern

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end


local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- Setup mason so it can manage external tooling
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {

    -- you can pin a tool to a particular version
    --{ 'golangci-lint', version = 'v1.47.0' },

    -- you can turn off/on auto_update per tool
    --{ 'bash-language-server', auto_update = true },

    "jdtls",
    "csharp_ls",
    "pyright",
    "tsserver",
    "gopls",
    --format
    "black",
    "flake8",
    "prettier",
    "sqlfluff",
    "stylua",
    --dap
    "js-debug-adapter",
    "debugpy",
    "netcoredbg"
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

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local lsp_servers = { 'bashls', 'dockerls', 'jsonls', 'pyright', 'tsserver', 'tailwindcss',
                      'lua_ls', 'sqlls', 'svelte', 'gopls', 'yamlls', 'astro', 'csharp_ls', 'jdtls' }

-- Ensure the servers above are installed
-- require('mason-lspconfig').setup {
--   ensure_installed = lsp_servers,
-- }

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(lsp_servers) do
  require('lspconfig')[lsp].setup {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities,
  }
end


-- Turn on lsp status information
require('fidget').setup()

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MasonToolsUpdateCompleted',
    callback = function()
      vim.schedule(function()
        print 'mason-tool-installer has finished'
      end)
    end,
  })


-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
        },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

require('lspconfig').tsserver.setup{
  -- filetypes = {"typescript", "typescriptreact", "typescript.tsx"}
-- root_dir = require('lspconfig.util').root_pattern('package.json')
  root_dir = vim.loop.cwd
}

