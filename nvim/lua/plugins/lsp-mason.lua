return { -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
  },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- LSP
    "seblj/roslyn.nvim",
    "nvim-lua/lsp-status.nvim",
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local home = require("utils").home
    local util = require("lspconfig.util")
    local utils = require("utils")
    local pid = vim.fn.getpid()

    -- lsp_signature
    local on_attach_lsp_signature = function(client, bufnr)
      -- https://github.com/ray-x/lsp_signature.nvim#full-configuration-with-default-values
      require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window = true,
        handler_opts = {
          border = "single",
        },
        zindex = 99,          -- <100 so that it does not hide completion popup.
        fix_pos = false,      -- Let signature window change its position when needed, see GH-53
        toggle_key = "<M-x>", -- Press <Alt-x> to toggle signature on and off.
      })
    end

    -- Specify how the border looks like
    local border = {
      { "┌", "FloatBorder" },
      { "─", "FloatBorder" },
      { "┐", "FloatBorder" },
      { "│", "FloatBorder" },
      { "┘", "FloatBorder" },
      { "─", "FloatBorder" },
      { "└", "FloatBorder" },
      { "│", "FloatBorder" },
    }

    -- Add the border on hover and on signature help popup window
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }

    -- Add border to the diagnostic popup window
    vim.diagnostic.config({
      virtual_text = {
        prefix = "■ ", -- Could be '●', '▎', 'x', '■', , 
      },
      float = { border = border },
    })

    -- LSP settings.
    --  This function gets run when an LSP connects to a particular buffer.
    _G.on_attach = function(server_name)
      return function(client, bufnr)
        -- Create a command `:Format` local to the LSP buffer
        -- Set keymaps here so they only pertain to buffers that a lang server attaches too
        -- buffer=0 means only set for current buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          if vim.lsp.buf.format then
            vim.lsp.buf.format()
          elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
          end
        end, { desc = "Format current buffer with LSP" })

        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end

        on_attach_lsp_signature(client, bufnr)

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = 0 })
        vim.keymap.set(
          "n",
          "gd",
          "<cmd>lua vim.lsp.buf.definition()<cr>",
          { buffer = 0, desc = "LSP Go To Definition" }
        )
        vim.keymap.set(
          "n",
          "gt",
          "<cmd>lua vim.lsp.buf.type_definition()<cr>",
          { buffer = 0, desc = "LSP Go to Type Definition" }
        )
        vim.keymap.set(
          "n",
          "gi",
          "<cmd>lua vim.lsp.buf.implementation()<cr>",
          { buffer = 0, desc = "LSP Go to implementation" }
        )
        vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {
          buffer = 0,
          desc = "LSP Telescope diagnostics",
        })
        vim.keymap.set("n", "rn", ":lua vim.lsp.buf.rename()<cr>", { buffer = 0, desc = "LSP Rename Variable" })
        vim.keymap.set(
          "n",
          "gc",
          ":lua vim.lsp.buf.code_action()<cr>",
          { buffer = 0, desc = "LSP Code action" }
        )
        vim.keymap.set(
          "n",
          "gD",
          ":lua vim.lsp.buf.declaration()<cr>",
          { buffer = 0, desc = "LSP Go To Declaration" }
        )
        vim.keymap.set(
          "n",
          "gr",
          ":lua require('telescope.builtin').lsp_references()<cr>",
          { buffer = 0, desc = "LSP Telescope Find References" }
        )
        vim.keymap.set(
          "n",
          "gR",
          ":lua vim.lsp.buf.references()<cr>",
          { buffer = 0, desc = "LSP Find References" }
        )
        vim.keymap.set(
          "n",
          "gs",
          ":lua vim.lsp.buf.signature_help()<cr>",
          { buffer = 0, desc = "LSP Signature" }
        )
        -- Lesser used LSP functionality
        vim.keymap.set("n", "<leader>wa", ":lua vim.lsp.buf.add_workspace_folder()<cr>")
        vim.keymap.set("n", "<leader>wr", ":lua vim.lsp.buf.remove_workspace_folder()<cr>")
        --Diagnostic keymaps
        vim.keymap.set(
          "n",
          "[d",
          "<cmd>vim.diagnostic.goto_prev()<cr>",
          { buffer = 0, desc = "Go to prev diagnostic" }
        )
        vim.keymap.set(
          "n",
          "]d",
          "<cmd>vim.diagnostic.goto_next()<cr>",
          { buffer = 0, desc = "Go to next diagnostic" }
        )
        vim.keymap.set(
          "n",
          "<LocalLeader>do",
          "<cmd>vim.diagnostic.open_float()<cr>",
          { buffer = 0, desc = "Diagnostics open float" }
        )
        vim.keymap.set(
          "n",
          "<leader>q",
          "<cmd>vim.diagnostic.setloclist()<cr>",
          { buffer = 0, desc = "Set loc list" }
        )
        vim.keymap.set(
          "n",
          "<LocalLeader>dh",
          ":lua vim.diagnostic.hide()<CR>",
          { buffer = 0, desc = "Hide diagnostics" }
        )
        vim.keymap.set(
          "n",
          "<LocalLeader>ds",
          ":lua vim.diagnostic.show()<CR>",
          { buffer = 0, desc = "Show diagnostics" }
        )
        vim.keymap.set("n", "<leader>F",
          ":lua require('conform').format({ lsp_fallback = true, async = false, timeout_ms= 500,})<CR>",
          { buffer = 0, desc = "Format" })
        vim.keymap.set(
          "n",
          "<leader>ls",
          ":lua require('telescope.builtin').lsp_document_symbols()<cr>",
          { buffer = 0, desc = "LSP document symbol" }
        )
        vim.keymap.set(
          "n",
          "<leader>ws",
          ":lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
          { buffer = 0, desc = "LSP workspace symbol" }
        )

        -- Goto Preview
        vim.keymap.set(
          "n",
          "gpd",
          "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
          { buffer = 0, desc = "Definition - Goto preview " }
        )
        vim.keymap.set(
          "n",
          "gpt",
          "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
          { buffer = 0, desc = "Type - Goto preview " }
        )
        vim.keymap.set(
          "n",
          "gpi",
          "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
          { buffer = 0, desc = "Implementation - Goto preview " }
        )
        vim.keymap.set(
          "n",
          "gpD",
          "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
          { buffer = 0, desc = "Declaration - Goto preview " }
        )
        vim.keymap.set(
          "n",
          "gpc",
          "<cmd>lua require('goto-preview').close_all_win()<CR>",
          { buffer = 0, desc = "Close - Goto preview " }
        )
        vim.keymap.set(
          "n",
          "gpr",
          "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
          { buffer = 0, desc = "References - Goto preview " }
        )

        if server_name == "roslyn" then
        end

        if server_name == "jdtls" then
          vim.keymap.set(
            "n",
            "<leader>dvc",
            "<cmd>lua require('jdtls').test_class()<cr>",
            { buffer = 0, desc = "Java Test Class" }
          )
          vim.keymap.set(
            "n",
            "<leader>dvm",
            "<cmd>lua require('jdtls').test_nearest_method()<cr>",
            { buffer = 0, desc = "Java Test Nearest Method" }
          )
        end

        if server_name == "vtsls" then
          client.server_capabilities.documentFormattingProvider = false
        end
      end
    end
    -- Mason path ~/.local/share/nvim/mason/bin

    local pid = vim.fn.getpid()
    local root_pattern = require("lspconfig.util").root_pattern
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    local lsp_status = require("lsp-status")
    lsp_status.register_progress()

    -- Setup mason so it can manage external tooling
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local ensure_installed = {
      "angularls",
      "astro",
      "bashls",
      "biome",
      "dockerls",
      --'gopls',
      "jdtls",
      "jsonls",
      "lemminx",
      "lua_ls",
      "pyright",
      "svelte",
      "tailwindcss",
      "yamlls",
      --"phpactor",
      --"php-debug-adapter",
      "pyright",
      "sqlls",
      "yamlls",
      "vtsls"
    }

    local mason_non_lsps = {

      "kotlin-language-server",
      "kotlin-debug-adapter",
      "java-debug-adapter",
      "java-test",
      "eslint_lsp",
      --format
      "black",
      "flake8",
      "prettier",
      "stylua",
      --dap
      "js-debug-adapter",
      "debugpy",
      "netcoredbg",
    }

    -- Enable the following language servers
    -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
    local lsp_servers = {
      "angularls",
      "astro",
      "bashls",
      "biome",
      "dockerls",
      "eslint",
      "gopls",
      "jdtls",
      "jsonls",
      "lemminx",
      "lua_ls",
      "kotlin_language_server",
      "pyright",
      "sqlls",
      "svelte",
      "tailwindcss",
      "yamlls",
    }

    -- Ensure the servers above are installed
    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
    })

    -- nvim-cmp supports additional completion capabilities, broadcast that to servers
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )
    --capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

    for _, lsp in ipairs(lsp_servers) do
      lspconfig[lsp].setup({
        on_attach = _G.on_attach(lsp),
        handlers = handlers,
        capabilities = capabilities,
      })
    end

    lspconfig.jdtls.setup({
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = home .. "/.asdf/installs/java/openjdk-21",
                default = true,
              },
            },
          },
        },
      },
    })

    -- Turn on lsp status information
    require("fidget").setup()

    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsUpdateCompleted",
      callback = function()
        vim.schedule(function()
          print("mason-tool-installer has finished")
        end)
      end,
    })

    -- Make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lspconfig.lua_ls.setup({
      on_attach = _G.on_attach("lua_ls"),
      capabilities = capabilities,
      handlers = handlers,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT)
            version = "LuaJIT",
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = { enable = false },
        },
      },
    })

    require("roslyn").setup({
      config = {
        on_attach = _G.on_attach("roslyn"),
        handlers = handlers,
        capabilities = capabilities,
        cmd = {
          "dotnet",
          vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
        },
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
        },
      },
    })

    lspconfig.sqls.setup({
      on_attach = _G.on_attach("sqls"),
      capabilities = capabilities,
      handlers = handlers,
      cmd = {
        utils.isWindows and utils.neovim_home .. "/mason/packages/sqls/sqls.exe"
        or utils.neovim_home .. "/mason/bin/sqls",
        "--config",
        utils.home .. "/.config/sqls.yml",
      },
      -- root_dir = function(fname)
      --   return root_pattern(fname) or vim.loop_os_homedir()
      -- end
    })

    lspconfig.vtsls.setup({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
      root_dir = util.root_pattern("package.json"),
      handlers = handlers,
      on_attach = _G.on_attach("vtsls"),
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
      },
    })

    -- For debugging you must install delve https://www.youtube.com/watch?v=i04sSQjd-qo
    lspconfig.gopls.setup({
      on_attach = _G.on_attach("gopls"),
      capabilities = capabilities,
      handlers = handlers,
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    })
  end,
}
