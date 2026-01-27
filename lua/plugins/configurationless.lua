return {
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "netcoredbg",
                "js-debug-adapter",
                "delve",

            },
        },
        config = function()
            require("mason").setup()
        end,
    },

    {
        "nvim-lua/plenary.nvim",
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "omnisharp", "marksman", "vtsls", "html", "cssls", "jsonls" },
            })
        end,
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
}
