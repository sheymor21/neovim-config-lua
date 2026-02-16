return {
    "stevearc/overseer.nvim",
    cmd = {
        "OverseerRun",
        "OverseerToggle",
        "OverseerBuild",
        "OverseerQuickAction",
        "OverseerTaskAction",
    },
    keys = {
        { "<leader>or", "<cmd>OverseerRun<CR>", desc = "Overseer Run" },
        { "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "Overseer Toggle" },
    },
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
