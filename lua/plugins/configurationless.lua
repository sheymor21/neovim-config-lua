return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "antosha417/nvim-lsp-file-operations",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
}
