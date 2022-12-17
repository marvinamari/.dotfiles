require('config.lsp.coq')
require('config.lsp.null-ls')
require('config.lsp.mason')
require('config.lsp.lsp-inlay-hints')

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'omnisharp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
    -- on_attach = my_custom_on_attach,
  }))
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}


local pid = vim.fn.getpid()
local omnisharp_bin = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/omnisharp/omnisharp'
local root_pattern = require('lspconfig.util').root_pattern

require'lspconfig'.omnisharp.setup{
    cmd = { "dotnet", omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid), "-s", io.popen"cd":read'*l' },
    root_dir = function(path)
      -- Make sure an sln doesn't already exist before trying to use nearest csproj
      return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
    end,
    -- Additional configuration can be added here
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = true,
    enable_roslyn_analyzers = false,
    organize_imports_on_format = false,
    enable_import_completion = true,
    sdk_include_prereleases = true,
    analyze_open_documents_only = false,
    on_attach = on_attach
}

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

