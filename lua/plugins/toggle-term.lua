return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
  },
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = nil,
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "rounded",
      },
    })
  end,
}
