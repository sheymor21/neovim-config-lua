return {
    "tpope/vim-dadbod",
    lazy = false,
    dependencies = {
        {
            "kristijanhusak/vim-dadbod-ui",
            lazy = false,
            config = function()
                require("config.dadbod")
            end,
        },
        {
            "kristijanhusak/vim-dadbod-completion",
            lazy = false,
            dependencies = { "nvim-lua/plenary.nvim" },
            -- No setup needed: blink.cmp integration is handled in lua/plugins/blink-cmp.lua
            -- via the providers table (module = "vim_dadbod_completion.blink").
        },
    },
}
