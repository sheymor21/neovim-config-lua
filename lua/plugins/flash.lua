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
        {
            "f",
            mode = { "n", "x", "o" },
            function() require("flash").jump() end,
            desc = "Flash Jump"
        },
        {
            "F",
            mode = { "n", "x", "o" },
            function() require("flash").treesitter() end,
            desc = "Flash Treesitter"
        },
        { "s", mode = { "n", "x", "o" }, false },
        { "S", mode = { "n", "x", "o" }, false },
    }
}
