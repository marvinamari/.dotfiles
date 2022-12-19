require'bufferline'.setup{
  options = {
    view =  'default',
    buffer_close_icon= '',
    close_icon = '',
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is deduplicated
    tab_size = 18,
    diagnostics = 'nvim_lsp',
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'directory',

        highlights = {
            tab_selected = {
                --guifg = tabline_sel_bg,
                guibg = '#ffffff'
            },
    },
    numbers = 'both',
}
}

