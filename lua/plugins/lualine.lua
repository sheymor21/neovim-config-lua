return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                section_separators = "",
                component_separators = "",

            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = {
                    "filename",
                    "navic",
                },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        })
    end,
}
