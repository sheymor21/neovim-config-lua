return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",

  config = function()
    require("trouble").setup({
      auto_close = true,
      use_diagnostic_signs = true,
    })
  end,
}
