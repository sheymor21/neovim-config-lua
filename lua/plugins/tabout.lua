return {
    "abecodes/tabout.nvim",
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
        "saghen/blink.cmp",
    },
    config = function()
        require("tabout").setup({
            tabkey = "",
            backwards_tabkey = "",
            completion = false,
            act_as_tab = true,
            enable_backwards = true,
        })
    end,
}
