return {
    "sheymor21/unipackage.nvim",
    lazy = "VeryLazy",
    config = function()
        require("unipackage").setup({
            fallback_to_any = false,
            search_batch_size = 15,
            ui = {
                telescope = false,
            },
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
