return {
    "sheymor21/unipackage.nvim",
    lazy = "VeryLazy",
    config = function()
        require("unipackage").setup({
            fallback_to_any = false,
            picker = "snacks",
            search_batch_size = 15,
            version_selection = {
                enabled = true,
                languages = {
                    javascript = false,
                    dotnet = true,
                },
                include_prerelease = false,
                max_versions_shown = 20,
            },
        })
    end,
}
