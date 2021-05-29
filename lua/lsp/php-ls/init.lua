require'lspconfig'.phpactor.setup{
    cmd = { "phpactor", "language-server" },
    filetypes = { "php" },
--    root_dir = root_pattern("composer.json", ".git")
}
