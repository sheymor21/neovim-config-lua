return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            search = { enabled = false },
            char = { enabled = false },
        },
        label = {
            rainbow = { enabled = false },
            uppercase = true,
            before = true, -- Label before match
            after = false, -- Don't put label after
        },
        highlight = {
            groups = {
                label = "IncSearch",
                match = "Normal",
                backdrop = "Comment",
            },
        },
    },
    keys = {
        { "s", mode = { "n", "x", "o" }, false },
        { "S", mode = { "n", "x", "o" }, false },
    }
}
