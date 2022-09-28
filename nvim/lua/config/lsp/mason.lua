require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Mason does not have an ensure installed option so below we install using autocmd
local present, mason = pcall(require, "mason")

if not present then
  return
end

local options = {
  ensure_installed = {
    "lua-language-server",
    "pyright", "black", "flake8",
    "prettier",
    "sqlfluff",
    --"quick-lint-js",
    "typescript-language-server",
    --dap
    "js-debug-adapter" }, -- not an option from mason.nvim
  max_concurrent_installers = 10,
}

mason.setup(options)

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
end, {})
