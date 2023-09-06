-- Mason path ~/.local/share/nvim/mason/bin

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

    "omnisharp_mono",
    "black",
    "flake8",
    "debugpy",
    "prettier",
    "sqlfluff",
    "stylua",
    --dap
    "js-debug-adapter",
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
                      'lua_ls', 'sqlls', 'svelte', 'gopls', 'yamlls', 'astro', 'omnisharp' }

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
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
        },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

local pid = vim.fn.getpid()
local home = vim.fn.has('unix') and os.getenv('HOME') or os.getenv('USERPROFILE')
local omnisharp_bin = vim.fn.has('unix') and home .. '/.local/share/nvim/mason/packages/omnisharp-mono/run' or home .. '/AppData/Local/nvim-data/mason/packages/omnisharp/OmniSharp.exe'
local root_pattern = require('lspconfig.util').root_pattern

require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid)}, --, "-s", io.popen"cd":read'*l' },
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    root_dir = function(path)
      -- Make sure an sln doesn't already exist before trying to use nearest csproj
      return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
    end,
    -- Additional configuration can be added here
    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,
    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,
    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,
    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,
    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = true,
    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,
    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
    on_attach = on_attach
}

