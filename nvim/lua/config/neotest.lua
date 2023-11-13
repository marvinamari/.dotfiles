require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require "neotest-rust",
    require("neotest-dotnet")({
      dap = { justMyCode = false},
    }),
    require "neotest-scala",
    require "neotest-haskell",
    require "neotest-jest",
    require "neotest-go",
    require "neotest-plenary",
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua", "cs", "rust", "scala", "haskell" },
    }),
  },
})
