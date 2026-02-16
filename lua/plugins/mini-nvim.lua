return {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
        require("mini.animate").setup({
            scroll = { enabled = true },
            cursor = { enabled = true },
        })
    end,
}
