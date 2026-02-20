return {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
        -- Defer mini.animate setup to avoid startup cost
        vim.api.nvim_create_autocmd({ "CursorMoved", "WinScrolled" }, {
            once = true,
            callback = function()
                require("mini.animate").setup({
                    scroll = { enabled = true },
                    cursor = { enabled = true },
                })
            end,
        })
    end,
}
