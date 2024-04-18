return {
  'BurntSushi/ripgrep',
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    'm-demare/hlargs.nvim',
    config = function()
      require('hlargs').setup {
      }
      -- (You may omit the settings whose defaults you're ok with)
    end
  },
  -- Editor
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require('catppuccin').setup({
  --       flavour = "mocha",
  --       -- highlight_overrides = {
  --       --   mocha = function(colors)
  --       --     return {
  --       --       Visual = { bg = colors.sapphire }
  --       --     }
  --       --   end
  --       -- }
  --
  --     })
  --   end
  -- },
  {
    'marko-cerovac/material.nvim',
    config = function()
      local material = require 'material'
      local colors = require 'material.colors'
      vim.g.material_style = "darker"
      material.setup({

        contrast = {
          terminal = false,          -- Enable contrast for the built-in terminal
          sidebars = false,          -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false,  -- Enable contrast for floating windows
          cursor_line = false,       -- Enable darker background for the cursor line
          lsp_virtual_text = false,  -- Enable contrasted background for lsp virtual text
          non_current_windows = false, -- Enable contrasted background for non-current windows
          filetypes = {},            -- Specify which filetypes get the contrasted (darker) background
        },

        styles = { -- Give comments style such as bold, italic, underline etc.
          comments = { italic = true },
          strings = { --[[ bold = true ]] },
          keywords = { --[[ underline = true ]] },
          functions = { --[[ bold = true, undercurl = true ]] },
          variables = {},
          operators = {},
          types = {},
        },

        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          -- "coc"
          "dap",
          -- "dashboard",
          -- "eyeliner",
          -- "fidget",
          -- "flash",
          "gitsigns",
          -- "harpoon",
          -- "hop",
          -- "illuminate",
          -- "indent-blankline",
          -- "lspsaga",
          -- "mini",
          -- "neogit",
          -- "neotest",
          -- "neo-tree",
          -- "neorg",
          -- "noice",
          "nvim-cmp",
          -- "nvim-navic",
          -- "nvim-tree",
          "nvim-web-devicons",
          "rainbow-delimiters",
          -- "sneak",
          "telescope",
          "trouble",
          "which-key",
          -- "nvim-notify",
        },

        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false,     -- Disable borders between verticaly split windows
          background = false,  -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false, -- Prevent the theme from setting terminal colors
          eob_lines = false    -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = false -- Enable higher contrast text for darker style
        },

        lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true,  -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_colors = nil,   -- If you want to override the default colors, set this to a function

        custom_highlights = {}, -- Overwrite highlights with your own
      })
    end
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },

}
