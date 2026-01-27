return {
    "nvim-neotest/neotest",
    cmd = { "Neotest", "NeotestSummary" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/nvim-nio",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-plenary",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-plenary")({
                    min_init = "tests/minimal_init.lua",
                }),
            },
        })
    end,
}
