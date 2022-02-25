require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}

--vim.cmd[[highlight link TSError Normal]]
--local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
--parser_config.typescript.used_by= 'typescript.tsx'
