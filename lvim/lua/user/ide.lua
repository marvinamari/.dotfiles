local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.maplocalleader = '\\'

-- Plugins --
lvim.plugins = {

  "nvim-neotest/neotest",
  "kylechui/nvim-surround",
  "Wansmer/treesj",
  "folke/flash.nvim",
  "jamestthompson3/nvim-remote-containers",
  "chentoast/marks.nvim",
  ----- python
  "AckslD/swenv.nvim", -- environment picker
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest-python",
  ----- end python
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },
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
}

require('swenv').setup({ -- restart lang server after switching environments
  post_set_venv = function()
    vim.cmd("LspRestart")
  end,
})

require("marks").setup({})
require("nvim-surround").setup({})
require("treesj").setup({})
require("aerial").setup({})


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

-- Normal --
keymap("n", "<LocalLeader>b", ":BufferLinePick<CR>", opts)
keymap("n", "<LocalLeader>w", ":w<CR>", opts)
keymap("n", "<LocalLeader>c", ":BufferKill<CR>", opts)
keymap("n", "<LocalLeader>s", ":%s///g", opts)
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
-- Terminal ctrl+\

keymap("n", "<Space>tb", ":Telescope builtin<cr>", opts)
-- Visual --
-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- pipe operator to access system clipboard
keymap("v", "|", '"+', opts)

keymap("v", "Y", '"+y', opts) -- yank to system clipboard

keymap('n', '{', ':AerialPrev<CR>', opts)
keymap('n', '}', ':AerialNext<CR>', opts)
