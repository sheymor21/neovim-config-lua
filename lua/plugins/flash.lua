return {
    "folke/flash.nvim",
    event = "VeryLazy",

    opts = {
        modes = {
            search = { enabled = false },
            char = { enabled = true, jump_labels = true },
        },

        label = {
            rainbow = { enabled = false },
            uppercase = true,
        },

        highlight = {
            groups = {
                label = "IncSearch",
                match = "Search",
                backdrop = "Comment",
            },
        },
    },
}
