return {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        require("mini.animate").setup({
            scroll = { enabled = false },
            cursor = { enabled = true },
        })
    end,

}
