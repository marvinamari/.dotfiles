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
	    remaps = {
		highlights = {
		globals = {
			plugins = {
				telescope = {
					TelescopeBorder = { fg = "#1a1a2e", bg = "NONE" },
					TelescopePromptBorder = { fg = "NONE", bg = "NONE" },
					TelescopePromptNormal = { fg = "white", bg = "NONE" },
					TelescopePromptPrefix = { fg = "#84c49b", bg = "NONE" },
					
					TelescopePromptTitle = { fg = "black", bg = "#fb5c8e" },
					TelescopePreviewTitle = { fg = "black", bg = "#a29dff" },
					TelescopeResultsTitle = { fg = "black", bg = "#f79f79" },
					
					TelescopeResults = { bg = "NONE" },
					TelescopeNormal = { bg = "NONE" },
					TelescopeSelection = { bg = "#565393" },
				}
			}
		},
		doom_one = {
			--base = { Normal = {bg = "#FFFFFF"} },
		}
	}
	}
        })

--vim.cmd [[let g:airline_theme = 'sonokai']]
-- vim.g.airline_theme ='dracula'
-- vim.g.sonokai_style = 'default'
-- vim.g.sonokai_cursor = 'orange'
-- vim.g.sonokai_menu_selection_background ='green'
-- vim.g.sonokai_diagnostic_text_highlight ='0'
-- vim.g.airline_theme='dracula'


--vim.api.nvim_command('colorscheme sonokai')
