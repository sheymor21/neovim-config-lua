return {
    "reloader",
    dir = vim.fn.stdpath("config"),
    cmd = { "DevReload", "LspReload" },
    config = function()
        local reloader = require("config.reloader")

        -- Commands
        vim.api.nvim_create_user_command("DevReload", function()
            reloader.full_reload()
        end, { desc = "Full reload of LSP" })

        vim.api.nvim_create_user_command("LspReload", function()
            reloader.reload_lsp_only()
        end, { desc = "Reload LSP only" })
    end,
}
