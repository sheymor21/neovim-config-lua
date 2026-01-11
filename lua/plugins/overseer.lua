return {
    "stevearc/overseer.nvim",
    config = function()
        require("overseer").setup({
            strategy = {
                "terminal",
                direction = "float", -- o "horizontal"
                close_on_exit = false,
            },
            task_list = {
                direction = "bottom",
                min_height = 10,
            },
        })
    end,
}
