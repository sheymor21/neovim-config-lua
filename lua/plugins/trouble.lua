return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    { "<leader>isp", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
  },
  config = function()
    require("trouble").setup({
      auto_close = true,
      use_diagnostic_signs = true,
    })
  end,
}
