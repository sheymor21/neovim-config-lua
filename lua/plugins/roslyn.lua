return {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    config = function()
        require("roslyn").setup({
            filewatching = true,
            lock_target = true,
            config = {
                capabilities = capabilities,
                offset_encoding = "utf-16",
            },
        })
    end,
}
