local config = {
    cmd = {vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = _G.on_attach("jdtls")
}
require('jdtls').start_or_attach(config)
