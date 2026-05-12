return {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
    config = function()
        require("spider").setup()
        require("plugins-keymaps.spider-keymaps")
    end,
}
