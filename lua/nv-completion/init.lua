--" Use completion-nvim in every buffer
vim.api.nvim_command([[
	autocmd BufEnter * lua require'completion'.on_attach()
	]])

-- Server attachments
require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}

--" Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_set_keymap('i' , '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })

--" Set completeopt to have a better completion experience
vim.o.completeopt='menuone,noinsert,noselect'

--" Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

-- Chain completion list
vim.g.completion_chain_complete_list = {
            default = {
              default = {
                  { complete_items = { 'lsp', 'snippet' }},
                  { mode = '<c-p>'},
                  { mode = '<c-n>'}},
              comment = {},
              string = { { complete_items = { 'path' }} }}}

vim.g.completion_enable_auto_popup=1
vim.g.completion_enable_auto_hover=1

-- possible value: "length", "alphabet", "none"
vim.g.completion_sorting="lenght"

--vim.g.completion_matching_strategy_list=['exact', 'substring', 'fuzzy', 'all']
vim.g.completion_matching_smart_case=1
vim.g.completion_enable_snippet = 'snippets.nvim'
vim.g.completion_trigger_keyword_length =3
vim.g.completion_confirm_key = vim.api.nvim_replace_termcodes('<CR>', true, true, true)

-- Source completion
vim.g.completion_auto_change_source = 1

-- Customize chain with scope
vim.g.completion_chain_complete_list = {
    lua = {
        string= {
            { mode = '<c-p>'},
            { mode= '<c-n>'}},
        func = {
            { complete_items = {'lsp'}}},
        default = {
            {complete_items= {'lsp', 'snippet'}},
            {mode= '<c-p>'},
            {mode= '<c-n>'}},
        },
        default = {
            default = {
                {complete_items = {'lsp', 'snippet'}},
                { mode = '<c-p>'},
                { mode = '<c-n>'}},
        comment = {}
       }
    }

