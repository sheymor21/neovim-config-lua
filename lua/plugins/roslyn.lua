return {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        require("roslyn").setup({
            filewatching = true,
            lock_target = true,
            extensions = {
                razor = {
                    enabled = false,
                },
            },
            config = {
                capabilities = capabilities,
                offset_encoding = "utf-16",
            },
        })
    end,
}
