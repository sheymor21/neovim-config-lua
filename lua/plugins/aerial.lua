return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-web-devicons",
    },
    opts = {
        backends = { "lsp", "treesitter" },

        layout = {
            default_direction = "right",
            min_width = 30,
        },

        show_guides = true,

        filter_kind = {
            "Class",
            "Constructor",
            "Function",
            "Method",
            "Interface",
            "Module",
            "Struct",
        },

        highlight_on_jump = 300,
        close_on_select = false,
        autojump = false,
    },

    keys = {
        { "<leader>o", "<cmd>AerialToggle<CR>", desc = "Aerial (outline)" },
        { "{",         "<cmd>AerialPrev<CR>",   desc = "Prev symbol" },
        { "}",         "<cmd>AerialNext<CR>",   desc = "Next symbol" },
    },
}
