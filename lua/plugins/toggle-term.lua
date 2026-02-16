return {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
        { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
        { "<leader>ig", function() require("config.lazygit").toggle() end, desc = "LazyGit" },
        { "<leader>id", function() require("config.lazy-docker").toggle() end, desc = "LazyDocker" },
    },
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = nil,
            shading_factor = 2,
            direction = "float",
            float_opts = {
                border = "rounded",
            },
        })
    end,
}
