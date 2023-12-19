local home = require('utils').home

local bundles = {
    vim.fn.glob( home .. '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' )
}

-- Extend for debugging tests
vim.list_extend(bundles, vim.split(vim.fn.glob( home .. '/.local/share/nvim/mason/packages/java-test/extension/server/*.jar', 1 ), "\n"))

local config = {
    cmd = {vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = _G.on_attach("jdtls"),
    hotcoderplace = 'auto',
    init_options = {
        bundles = bundles
    },
}
require('jdtls').start_or_attach(config)
require('dap.ext.vscode').load_launchjs()
