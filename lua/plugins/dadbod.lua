return {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUIToggle", "DBUIRenameBuffer", "DBUIExecuteQuery", "DBUIToggleNERDTree", "DBUIAddConnection", "DBUIBackspace" },
    ft = { "sql" },

    dependencies = {
        {
            "kristijanhusak/vim-dadbod-ui",
            cmd = { "DBUIToggle", "DBUICloseTab", "DBUIRenameBuffer", "DBUIExecuteQuery", "DBUIToggleNERDTree", "DBUIAddConnection" },
            ft = { "sql" },
            config = function()
                require("config.dadbod")
            end,
        },
        {
            "kristijanhusak/vim-dadbod-completion",
            cmd = { "DBCompletionClearCache" },
            ft = { "sql", "mysql", "plsql" },
            dependencies = { "nvim-lua/plenary.nvim" },
            -- No setup needed: blink.cmp integration is handled in lua/plugins/blink-cmp.lua
            -- via the providers table (module = "vim_dadbod_completion.blink").
        },
    },
}
