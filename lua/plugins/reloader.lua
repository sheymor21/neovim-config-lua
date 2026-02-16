return {
    "reloader",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    config = function()
        local reloader = require("config.reloader")

        -- Commands
        vim.api.nvim_create_user_command("DevReload", function()
            reloader.full_reload()
        end, { desc = "Full reload of LSP and CMP" })

        vim.api.nvim_create_user_command("LspReload", function()
            reloader.reload_lsp_only()
        end, { desc = "Reload LSP only" })

        vim.api.nvim_create_user_command("CmpReload", function()
            reloader.reload_cmp_only()
        end, { desc = "Reload CMP only" })
    end,
}
