require'lspconfig'.cssls.setup{
    cmd = { "css-languageserver", "--stdio" },
    filetypes = { "css", "scss", "less" },
--  :    root_dir = root_pattern("package.json"),
    settings = {
      css = {
        validate = true
      },
      less = {
        validate = true
      },
      scss = {
        validate = true
      }
    }
}

