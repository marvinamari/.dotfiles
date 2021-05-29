require'lspconfig'.tsserver.setup{
--    cmd = { "typerscript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--    root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
--    opts = JSON.parse(fs.readFileSync(this.rootPath() + "./tsfmt.json", 'utf-8')),
--    tsserver= {
--        path = "/Users/amari/.nvm/versions/node/v14.4.0/bin/",
--        path = "/Users/amari/.nvm/versions/node/v14.4.0/bin/typescript-language-server",
--    },
    settings = {
        tabSize = 2,
        indent = 2,
        convertTabsToSpaces = true,
    }
}    
