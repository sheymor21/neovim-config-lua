return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  event = { "BufReadPost", "BufNewFile" },

  config = function()
    require("grapple").setup({
      icons = false,
      status = false,
      win_opts = {
        border = "rounded",
        footer = "",
      },
    })

    require("../plugins-keymaps/grapple-keymaps")
  end,
}
