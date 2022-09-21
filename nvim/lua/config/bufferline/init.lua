require'bufferline'.setup{
  numbers = function(opts)
    return string.format('%s|%s.'), opts.id, opts.raise(opts.ordinal)
  end,
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
    --diagnostics_indicator = function(count, level)
    --  return '('..count..')'
    --end
    -- NOTE: this will be called a lot so don't do any heavy processing here
   -- custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
   --   if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
    --    return true
     -- end
      -- filter out by buffer name
    --  if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
     --   return true
     -- end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
    --  if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
     --   return true
    --  end
   -- end,
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
--    sort_by = function(buffer_a, buffer_b)
--      -- add custom logic
--      return buffer_a.modified > buffer_b.modified
--    end
  --}

        highlights = {
--            fill = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>',
--            },
--            background = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>'
--            },
--            tab = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>'
--            },
            tab_selected = {
                guifg = tabline_sel_bg,
                guibg = '#ffffff'
            },
--            tab_close = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>'
--            },
--            buffer_visible = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>'
--            },
--            buffer_selected = {
--                guifg = normal_fg,
--                guibg = '<color-value-here>',
--                gui = 'bold,italic'
--            },
--            warning = {
--                guifg = '<color-value-here>',
--                gui = 'underline',
--                guisp = warning_fg,
--                guibg = '<color-value-here>'
--            },
--            warning_visible = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>',
--                gui = 'underline',
--                guisp = warning_fg
--            },
--            warning_selected = {
--                guifg = warning_fg,
--                guibg = '<color-value-here>',
--                gui = 'bold,italic,underline',
--                guisp = warning_fg
--            },
--            error = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>',
--                gui = 'underline',
--                guisp = '<color-value-here>'
--            },
--            error_visible = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>',
--                gui = 'underline',
--                guisp = '<color-value-here>'
--            },
--            error_selected = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>',
--                gui = 'bold,italic,underline',
--                guisp = '<color-value-here>'
--            },
--            modified = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>'
--            },
--            modified_visible = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>'
--            },
--            modified_selected = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>'
--            },
--            duplicate_selected = {
--                guifg = '<color-value-here>',
--                gui = 'italic',
--                guibg = '<color-value-here>'
--            },
--            duplicate_visible = {
--                guifg = '<color-value-here>',
--                gui = 'italic',
--                guibg = '<color-value-here>'
--            },
--            duplicate = {
--                guifg = '<color-value-here>',
--                gui = 'italic',
--                guibg = '<color-value-here>'
--            },
--            separator_selected = {
--                guifg = '<color-value-here>,
--                guibg = '<color-value-here>'
--            },
--            separator_visible = {
--                guifg = '<color-value-here>,
--                guibg = '<color-value-here>'
--            },
--            separator = {
--                guifg = '<color-value-here>,
--                guibg = '<color-value-here>'
--            },
--            indicator_selected = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>'
--            },
--            pick_selected = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>',
--                gui = 'bold,italic'
--            },
--            pick_visible = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>',
--                gui = 'bold,italic'
--            },
--            pick = {
--                guifg = '<color-value-here>',
--                guibg = '<color-value-here>',
--                gui = 'bold,italic'
--            }
--        };
    }
}
}

