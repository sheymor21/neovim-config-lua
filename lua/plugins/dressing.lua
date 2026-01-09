return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "➤ ",
      title_pos = "center",
      insert_only = false,
      start_in_insert = true,
      win_options = {
        winblend = 0,
      },
    },
    select = {
      enabled = true,
      backend = { "telescope", "builtin", "nui" },
      telescope = require("telescope.themes").get_cursor({
        initial_mode = "insert",
      }),
      builtin = {
        show_numbers = true,
        border = "rounded",
        relative = "editor",
        win_options = {
          winblend = 0,
        },
      },
    },
  },
}