require("diffview").setup({
  view = {
    merge_tool = {
      layout = "diff1_plain", --diff4_mixed
      disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
    }
  }
})
