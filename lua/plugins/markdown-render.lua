return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ft = { "markdown" },
        config = function()
            require('render-markdown').setup({})
        end,
    },
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        ft = { "markdown" },
        config = function()
            require("peek").setup({
                auto_load = true,
                close_on_bdelete = true,
                syntax = true,
                theme = 'dark',
                update_on_change = true,
                app = 'browser', -- Cambia a 'browser' en lugar de 'webview'
                filetype = { 'markdown' },
            })
        end,
    }
}
