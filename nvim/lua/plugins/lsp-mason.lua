return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  opts = {
    inlay_hints = { enabled = true },
  },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- LSP
    'jmederosalvarado/roslyn.nvim',
    'nvim-lua/lsp-status.nvim',
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      event = 'LspAttach'
    },

  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local home = require('utils').home
    local utils = require('utils')

    -- lsp_signature
    local on_attach_lsp_signature = function(client, bufnr)
      -- https://github.com/ray-x/lsp_signature.nvim#full-configuration-with-default-values
      require('lsp_signature').on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window = true,
        handler_opts = {
          border = "single"
        },
        zindex = 99,          -- <100 so that it does not hide completion popup.
        fix_pos = false,      -- Let signature window change its position when needed, see GH-53
        toggle_key = '<M-x>', -- Press <Alt-x> to toggle signature on and off.
      })
    end

    -- LSP settings.
    --  This function gets run when an LSP connects to a particular buffer.
    _G.on_attach = function(server_name)
      return function(_, bufnr)
        -- Create a command `:Format` local to the LSP buffer
        -- Set keymaps here so they only pertain to buffers that a lang server attaches too
        -- buffer=0 means only set for current buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          if vim.lsp.buf.format then
            vim.lsp.buf.format()
          elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
          end
        end, { desc = 'Format current buffer with LSP' })

        if _.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(bufnr, true)
        end

        on_attach_lsp_signature(_, bufnr)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "LSP Go To Definition" })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0, desc = "LSP Go to Type Definition" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0, desc = "LSP Go to implementation" })
        vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0, desc =
        "LSP Telescope diagnostics" })
        vim.keymap.set('n', 'rn', ':lua vim.lsp.buf.rename()<cr>', { buffer = 0, desc = 'LSP Rename Variable' })
        vim.keymap.set('n', 'gc', ':lua vim.lsp.buf.code_action()<cr>', { buffer = 0, desc = "LSP Code action" })
        vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', { buffer = 0, desc = 'LSP Go To Declaration' })
        vim.keymap.set('n', 'gr', ":lua require('telescope.builtin').lsp_references()<cr>",
          { buffer = 0, desc = 'LSP Telescope Find References' })
        vim.keymap.set('n', 'gR', ":lua vim.lsp.buf.references()<cr>", { buffer = 0, desc = 'LSP Find References' })
        vim.keymap.set('n', 'gs', ':lua vim.lsp.buf.signature_help()<cr>', { buffer = 0, desc = 'LSP Signature' })
        -- Lesser used LSP functionality
        vim.keymap.set('n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<cr>')
        vim.keymap.set('n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<cr>')
        --Diagnostic keymaps
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = 0, desc = 'Go to prev diagnostic' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = 0, desc = 'Go to next diagnostic' })
        vim.keymap.set('n', '<LocalLeader>do', vim.diagnostic.open_float, { buffer = 0, desc = 'Diagnostics open float' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { buffer = 0, desc = 'Set loc list' })
        vim.keymap.set('n', '<LocalLeader>dh', ':lua vim.diagnostic.hide()<CR>', { buffer = 0, desc = 'Hide diagnostics' })
        vim.keymap.set('n', '<LocalLeader>ds', ':lua vim.diagnostic.show()<CR>', { buffer = 0, desc = 'Show diagnostics' })
        vim.keymap.set('n', '<leader>F', ':lua vim.lsp.buf.format()<cr>', { buffer = 0, desc = 'LSP Format' })
        vim.keymap.set('n', '<leader>ls', ":lua require('telescope.builtin').lsp_document_symbols()<cr>",
          { buffer = 0, desc = 'LSP document symbol' })
        vim.keymap.set('n', '<leader>ws', ":lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
          { buffer = 0, desc = 'LSP workspace symbol' })

        -- Goto Preview
        vim.keymap.set('n', "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
          { buffer = 0, desc = "Definition - Goto preview " })
        vim.keymap.set('n', "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
          { buffer = 0, desc = "Type - Goto preview " })
        vim.keymap.set('n', "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
          { buffer = 0, desc = "Implementation - Goto preview " })
        vim.keymap.set('n', "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
          { buffer = 0, desc = "Declaration - Goto preview " })
        vim.keymap.set('n', "gpc", "<cmd>lua require('goto-preview').close_all_win()<CR>",
          { buffer = 0, desc = "Close - Goto preview " })
        vim.keymap.set('n', "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
          { buffer = 0, desc = "References - Goto preview " })

        if server_name == 'jdtls' then
          vim.keymap.set('n', "<leader>dvc", "<cmd>lua require('jdtls').test_class()<cr>",
            { buffer = 0, desc = "Java Test Class" })
          vim.keymap.set('n', "<leader>dvm", "<cmd>lua require('jdtls').test_nearest_method()<cr>",
            { buffer = 0, desc = "Java Test Nearest Method" })
        end
      end
    end
    -- Mason path ~/.local/share/nvim/mason/bin

    local pid = vim.fn.getpid()
    local root_pattern = require('lspconfig.util').root_pattern
    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig.configs'


    local lsp_status = require('lsp-status')
    lsp_status.register_progress()

    -- Setup mason so it can manage external tooling
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    require('mason-tool-installer').setup {

      -- a list of all tools you want to ensure are installed upon
      -- start; they should be the names Mason uses for each tool
      ensure_installed = {

        -- you can pin a tool to a particular version
        --{ 'golangci-lint', version = 'v1.47.0' },

        -- you can turn off/on auto_update per tool
        --{ 'bash-language-server', auto_update = true },
        "angular-language-server",
        "astro-language-server",
        --"biome",
        "gopls",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "lemminx",
        "lua-language-server",
        "kotlin-language-server",
        "kotlin-debug-adapter",
        --"phpactor",
        --"php-debug-adapter",
        "pyright",
        "sqls",
        "typescript-language-server",
        "yaml-language-server",
        --format
        "black",
        "flake8",
        "prettier",
        "sqlfluff",
        "stylua",
        --dap
        "js-debug-adapter",
        "debugpy",
        "netcoredbg"
      },

      -- if set to true this will check each tool for updates. If updates
      -- are available the tool will be updated. This setting does not
      -- affect :MasonToolsUpdate or :MasonToolsInstall.
      -- Default: false
      auto_update = false,

      -- automatically install / update on startup. If set to false nothing
      -- will happen on startup. You can use :MasonToolsInstall or
      -- :MasonToolsUpdate to install tools and check for updates.
      -- Default: true
      run_on_start = true,

      -- set a delay (in ms) before the installation starts. This is only
      -- effective if run_on_start is set to true.
      -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
      -- Default: 0
      start_delay = 3000, -- 3 second delay
    }

    -- Enable the following language servers
    -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
    local lsp_servers = { 'angularls', 'astro', 'bashls', 'dockerls', 'jsonls', 'lemminx',
      'kotlin_language_server', 'pyright', 'svelte', 'tailwindcss', 'yamlls' }

    -- Ensure the servers above are installed
    -- require('mason-lspconfig').setup {
    --   ensure_installed = lsp_servers,
    -- }

    -- nvim-cmp supports additional completion capabilities, broadcast that to servers
    local capabilities = vim.tbl_deep_extend("force",
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities()
    )
    --capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

    for _, lsp in ipairs(lsp_servers) do
      lspconfig[lsp].setup {
        on_attach = _G.on_attach(lsp),
        capabilities = capabilities,
      }
    end

    require('lspconfig').jdtls.setup({
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = home .. "/.asdf/installs/java/openjdk-21",
                default = true,
              }
            }
          }
        }
      }
    })

    require("roslyn").setup({
      on_attach = _G.on_attach("roslyn"),
      capabilities = capabilities,
    })


    -- Turn on lsp status information
    require('fidget').setup()

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MasonToolsUpdateCompleted',
      callback = function()
        vim.schedule(function()
          print 'mason-tool-installer has finished'
        end)
      end,
    })


    -- Make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    lspconfig.lua_ls.setup {
      on_attach = _G.on_attach("lua_ls"),
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = { enable = false },
        },
      },
    }

    lspconfig.sqls.setup({
      on_attach = _G.on_attach("sqls"),
      capabilities = capabilities,
      cmd = {utils.isWindows and utils.neovim_home .. "/mason/packages/sqls/sqls.exe" or utils.neovim_home .. "/mason/bin/sqls", "--config", utils.home .. "/.config/sqls.yml"},
      -- root_dir = function(fname)
      --   return root_pattern(fname) or vim.loop_os_homedir()
      -- end
    })

    lspconfig.tsserver.setup {
      -- filetypes = {"typescript", "typescriptreact", "typescript.tsx"}
      -- root_dir = require('lspconfig.util').root_pattern('package.json')
      on_attach = _G.on_attach("tsserver"),
      capabilities = capabilities,
      root_dir = vim.loop.cwd
    }

    -- For debugging you must install delve https://www.youtube.com/watch?v=i04sSQjd-qo
    lspconfig.gopls.setup {
      on_attach = _G.on_attach("gopls"),
      capabilities = capabilities,
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_dir = root_pattern('go.work', 'go.mod', '.git'),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          }
        }
      }

    }
  end
}
