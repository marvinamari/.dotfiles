return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Useful status updates for LSP
    'j-hui/fidget.nvim',
    'nvim-lua/lsp-status.nvim'
  },
  -- opts = {
        -- inlay_hints = { enabled = true }
    -- }
}
