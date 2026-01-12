return {
    "akinsho/toggleterm.nvim",
    version = "*",
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
