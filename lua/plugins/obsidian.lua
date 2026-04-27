return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("config.obsidian")
        end,
    },
}
