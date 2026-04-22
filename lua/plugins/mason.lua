return {
    {
        "mason-org/mason.nvim",
        -- Mason docs explicitly recommend NOT lazy-loading this plugin:
        -- "Lazy-loading the plugin, or somehow deferring the setup, is not recommended."
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { "marksman", "vtsls", "html", "cssls", "jsonls" },
        },
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut", "DapTerminate", "DapToggleRepl" },
        dependencies = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            automatic_installation = true,
            ensure_installed = {
                "netcoredbg",
                "js-debug-adapter",
                "delve",
            },
        },
    },
}
