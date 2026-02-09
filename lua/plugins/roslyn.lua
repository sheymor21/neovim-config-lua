return {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("roslyn").setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                vim.notify("ROSYLN ATTACHED", vim.log.levels.INFO)
                _G.lsp_on_attach(client, bufnr)
            end,

            settings = {
                ["csharp|background_analysis"] = {
                    dotnet_analyzer_diagnostics_scope = "fullSolution",
                    dotnet_compiler_diagnostics_scope = "fullSolution",
                },
                ["csharp|completion"] = {
                    provide_snippets = true,
                },
            },
        })
    end,
}
