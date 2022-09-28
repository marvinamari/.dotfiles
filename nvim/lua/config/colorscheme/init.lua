if vim.fn.has('termguicolors') == 1 then
         vim.api.nvim_command('set termguicolors')
end
require("themer").setup({
            colorscheme = "doom_one",
            styles = {
                ["function"] = { style = 'italic' },
                functionbuiltin = { style = 'italic' },
                variable = { style = 'italic' },
                  variableBuiltIn = { style = 'italic' },
                parameter  = { style = 'italic' },
            },
        })

--vim.cmd [[let g:airline_theme = 'sonokai']]
-- vim.g.airline_theme ='dracula'
-- vim.g.sonokai_style = 'default'
-- vim.g.sonokai_cursor = 'orange'
-- vim.g.sonokai_menu_selection_background ='green'
-- vim.g.sonokai_diagnostic_text_highlight ='0'
-- vim.g.airline_theme='dracula'


--vim.api.nvim_command('colorscheme sonokai')
