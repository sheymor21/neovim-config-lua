return {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    -- LazyGit (<leader>ig) and LazyDocker (<leader>id) moved to snacks.nvim
    -- ToggleTerm kept for unirunner, unipackage, unidiagnostic custom plugins
    cmd = "ToggleTerm",
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
