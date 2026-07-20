return {
    "reloader",
    dir = vim.fn.stdpath("config"),
    cmd = { "DevReload", "LspReload" },
    config = function()
        local reloader = require("config.reloader")

        vim.api.nvim_create_user_command("DevReload", function()
            reloader.full_reload()
        end, { desc = "Full reload of LSP" })

        vim.api.nvim_create_user_command("LspReload", function(opts)
            local server = vim.trim(opts.args)
            if server == "" then
                reloader.reload_lsp_only()
            else
                reloader.reload_server(server)
            end
        end, {
            desc = "Reload LSP (all or specific server)",
            nargs = "?",
            complete = function(arg_lead)
                local servers = require("lsp.servers")
                local names = {}
                for _, server in ipairs(servers.servers) do
                    if vim.startswith(server.name, arg_lead) then
                        table.insert(names, server.name)
                    end
                end
                return names
            end,
        })
    end,
}
