require'lspconfig'.dockerls.setup{
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "Dockerfile", "dockerfile" },
--    root_dir = root_pattern("Dockerfile")
}
