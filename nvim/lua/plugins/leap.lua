return {
  "ggandor/leap.nvim",
  config = function()
    require("leap").add_default_mappings()
    -- require("flash").jump({
    -- modes = {
    --     search = {
    --         search = {
    --             incremental = true,
    --             trigger = ";",
    --         },
    --     },
    -- },
    -- })
  end
}
