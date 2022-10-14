local M = {}

function M.setup()
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
        runner = "unittest",
      },
      require "neotest-rust",
      require "neotest-dotnet",
      require "neotest-scala",
      require "neotest-haskell",
      require "neotest-jest",
      require "neotest-go",
      require "neotest-plenary",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua", "cs", "rust", "scala", "haskell" },
      },
    },
  }
end

return M
