return {
    "sheymor21/unidiagnostic.nvim",
    dependencies = {
        "akinsho/toggleterm.nvim",
    },
    lazy = "VeryLazy",
    config = function()
        require("unidiagnostic").setup({
            -- Window position
            position = "center", -- 'center' | 'top-left' | 'top-right' | 'bottom-left' | 'bottom-right'
            width = 80,
            height = 20,
            border = "rounded",
            -- Navigation keys (Colemak-friendly by default, fully customizable)
            keys = {
                open = "<CR>", -- jump to diagnostic location
                close = "q", -- close window
            },
            -- Behavior
            auto_refresh = true,
            severity_sort = true, -- Error > Warn > Info > Hint
            fold_by_default = true,
        })
    end,
}
