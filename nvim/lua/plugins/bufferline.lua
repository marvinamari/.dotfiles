return {
  'akinsho/nvim-bufferline.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require 'nvim-web-devicons'.setup {
      -- your personnal icons can go here (to override)
      -- DevIcon will be appended to `name`
      -- override = {
      --  zsh = {
      --    icon = '',
      --    color = '#428850',
      --    name = 'Zsh'
      --  }
      -- };
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
    };

    require 'bufferline'.setup {
      options = {
        view = 'default',
        buffer_close_icon = '󱄊',
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
        sort_by = 'id',

        highlights = {
          tab_selected = {
            fg = '#FFFFFF',
            bg = '#000000'
          },
        },
        numbers = 'ordinal'
      }
    }
  end
}
