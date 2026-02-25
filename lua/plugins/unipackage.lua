return {
    "sheymor21/unipackage.nvim",
    dependencies = {
        "akinsho/toggleterm.nvim",
    },
    config = function()
        require("unipackage").setup({
            fallback_to_any = false,
            search_batch_size = 15,
        })
    end,
}
