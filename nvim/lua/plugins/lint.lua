return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      markdown = { 'vale', }
    }
vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter"}, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function()
    lint.try_lint()
    lint.try_lint("cspell")
  end
})

  end
}
