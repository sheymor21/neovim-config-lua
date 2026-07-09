return {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    config = function()
        vim.lsp.config("roslyn", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
            offset_encoding = "utf-16",
        })

        require("roslyn").setup({
            filewatching = "auto",
            lock_target = true,
            extensions = {
                razor = {
                    enabled = false,
                },
            },
        })
    end,
}
