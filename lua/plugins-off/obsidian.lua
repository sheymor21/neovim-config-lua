return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        cmd = "Obsidian",
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("config.obsidian")
        end,
    },
}
