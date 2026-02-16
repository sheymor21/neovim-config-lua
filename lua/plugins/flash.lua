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
            before = true, -- Label antes del match
            after = false, -- No poner label después
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
