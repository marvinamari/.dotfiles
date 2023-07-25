local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.maplocalleader = '\\'

-- Plugins --
lvim.plugins = {

  "nvim-neotest/neotest",
  "kylechui/nvim-surround",
  "Wansmer/treesj",
  "folke/flash.nvim",
  "chipsenkbeil/distant.nvim",
  "simrat39/symbols-outline.nvim",
  "folke/trouble.nvim",
  -- "rmagatti/goto-preview",
  -- {
  --   "nvim-pack/nvim-spectre",
  --    dependencies = {"nvim-lua/plenary.nvim"}
  -- },
  {
  "chentoast/marks.nvim",
  branch= 'master'
  },
  "rest-nvim/rest.nvim",
  ----- python
  "AckslD/swenv.nvim", -- environment picker
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest-python",
  ----- end python
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = {
              mode = function(str)
                return "\\<" .. str
              end,
            },
          })
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  }

} -- end plugins

-- LSP
--// python
lvim.builtin.treesitter.ensure_installed = {
  "python",
  "http",
  "json",
}

require('swenv').setup({ -- restart lang server after switching environments
  post_set_venv = function()
    vim.cmd("LspRestart")
  end,
})

require("marks").setup({})
require("nvim-surround").setup({})
require("treesj").setup({})
require("symbols-outline").setup({})
-- require("spectre").setup({})
require("trouble").setup({})
-- require("goto-preview").setup({})
require("distant").setup({
  ['*'] = require("distant.settings").chip_default()
}) -- installed to /home/marvin/.local/share/lvim/distant.nvim/bin/distant
require("rest-nvim").setup({
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Encode URL before making request
      encode_url = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        -- show the generated curl command in case you want to launch
        -- the same request via the terminal (can be verbose)
        show_curl_command = false,
        show_http_info = true,
        show_headers = true,
        -- executables or functions for formatting response body [optional]
        -- set them to false if you want to disable them
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
          end
        },
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })

require("mason-lspconfig").setup {
  ensure_installed = { "pyright", "typescript-language-server", "debugpy"}
}


-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }

-- setup dap
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})


local dap = require('dap')
dap.adapters.generic_remote = function(callback, config)
  callback({
    type = 'server',
    host = (config.connect or config).host or '127.0.0.1',
    port = (config.connect or config).port or '5678',
    options = {
      source_filetype = 'python'
    }
})
end

-- table.insert(dap.configurations.python,
--   {
--     type = "generic_remote",
--     name = "Generic remote",
--     request = "attach",
--     justMyCode = false,
--     pathMappings = {{
--       localRoot = vim.fn.getcwd();
--       remoteRoot = "/";
--     }};
--   }
-- )

table.insert(dap.configurations.python,
  {
    type = "generic_remote",
    name = "Generic remote",
    request = "attach",
    justMyCode = false,
    connect = function()
      local host = vim.fn.input('Host [127.0.0.1]: ')
      host = host ~= '' and host or '127.0.0.1'
      local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
      return { host = host, port = port }
    end,
    pathMappings = {{
      localRoot = vim.fn.getcwd();
      remoteRoot = "/";
    }};
  }
)

-- Commands --
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }


-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

-- Keymaps --

-- Insert --
keymap('i', '<C-l>', '<Right>', opts)
keymap('i', '<C-h>', '<Left>', opts)
keymap('i', '<C-j>', '<Down>', opts)
keymap('i', '<C-k>', '<Up>', opts)

--
-- Normal --
--
-- dap
keymap("n", "<F5>", ":lua require('dap').continue()<cr>", opts)
keymap("n", "<F10>", ":lua require('dap').step_over()<cr>", opts)
keymap("n", "<F11>", ":lua require('dap').step_into()<cr>", opts)
keymap("n", "<S-F11>", ":lua require('dap').step_out()<cr>", opts)
keymap("n", "<LocalLeader>b", ":BufferLinePick<CR>", opts)
keymap("n", "<LocalLeader>w", ":w<CR>", opts)
keymap("n", "<LocalLeader>c", ":BufferKill<CR>", opts)
keymap("n", "<LocalLeader>s", ":SymbolsOutline<cr>", opts)
-- keymap("n", "<LocalLeader>s", ":%s///g", opts)
keymap("n", "<LocalLeader>j", ":lua require('trevj).format_at_cursor()<CR>", opts)
keymap("n", "<S-h>", ":bprev<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
-- pipe operator to access system clipboard
keymap("n", "|", '"+', opts)
keymap("n", "||", '"-', opts)
-- single press indent --
keymap("n", ">", ">>", opts)
keymap("n", "<", "<<", opts)
keymap("n", "<LocalLeader>a", "<cmd>AerialToggle!<CR>", opts)

-- Trouble
keymap("n", "<Space>xx", ":TroubleToggle<cr>", opts)
keymap("n", "<Space>xw", ":lua require('trouble').open('workspace_diagnostics')<cr>", opts)
keymap("n", "<Space>xd", ":lua require('trouble').open('document_diagnostics')<cr>", opts)
keymap("n", "<Space>xl", ":lua require('trouble').open('quickfix')<cr>", opts)
keymap("n", "<Space>xq", ":lua require('trouble').open('loclist')<cr>", opts)

-- Goto Preview
-- keymap("n", "gpd", ":lua require('goto-preview').goto_preview_definition()<CR>", opts)
-- keymap("n", "gpt", ":lua require('goto-preview').goto_preview_type_definition()<CR>", opts)
-- keymap("n", "gpi", ":lua require('goto-preview').goto_preview_implementation()<CR>", opts)
-- keymap("n", "gP", ":lua require('goto-preview').close_all_win()<CR>", opts)
-- keymap("n", "gpr", ":lua require('goto-preview').goto_preview_references()<CR>", opts)

-- Terminal ctrl+\

keymap("n", "<LocalLeader>rr", ":RestNvim<cr>", opts)
keymap("n", "<LocalLeader>rp", ":RestNvimPreview<cr>", opts)
keymap("n", "<LocalLeader>rl", ":RestNvimLast<cr>", opts)

keymap("n", "<Space>tb", ":Telescope builtin<cr>", opts)
keymap("n", "<LocalLeader>f", ":lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })<cr>", opts)
-- Visual --
-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- pipe operator to access system clipboard
keymap("v", "|", '"+', opts)

keymap("v", "Y", '"+y', opts) -- yank to system clipboard

keymap('n', '{', ':AerialPrev<CR>', opts)
keymap('n', '}', ':AerialNext<CR>', opts)

lvim.builtin.which_key.mappings["f"] = {
  name = "Telescope",
  f = { "<cmd>Telescope find_files<cr>", "Find Files"},
  g = { "<cmd>Telescope live_grep<cr>", "Live Grep"}
}

-- Register keymaps with which-key
local wk = require("which-key")
wk.register({
  f = {
    name = "Find Files In Buffer"
  },
  r = { name = "Rest Requests",
    r = {":RestNvim<cr>", "Run request under cursor"},
    p = {":RestNvimPreview<cr>", "Preview request Curl command"},
    l = {":RestNvimLast<cr>", "Re-run last request"},
  },
}, { prefix = "<LocalLeader>" })
