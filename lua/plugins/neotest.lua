return {
    "nvim-neotest/neotest",
    cmd = { "Neotest", "NeotestSummary" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("neotest").setup({})
    end,
}
