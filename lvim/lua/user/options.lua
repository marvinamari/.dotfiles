-- Options
vim.opt.relativenumber = true
vim.opt.timeoutlen = 500
vim.opt.showcmd = true
vim.opt.clipboard = "" -- pairs with the '|' keymap
vim.opt_global.clipboard = ""
lvim.builtin.treesitter.ensure_installed = "all"
vim.cmd([[hi Container guifg=#BADA55 guibg=Black]])
-- set dynamic value use vim.fn
vim.api.nvim_command([[set statusline+=%#Container#]] .. vim.fn.expand("g:currentContainer"))
