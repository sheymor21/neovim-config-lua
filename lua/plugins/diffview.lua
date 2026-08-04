return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
  },
  config = function()
    require("config.diffview").setup()
    require("plugins-keymaps.diffview-keymaps")
  end,
}
