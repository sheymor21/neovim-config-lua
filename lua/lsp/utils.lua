local M = {}

-- Start or attach to existing LSP client using built-in Neovim functionality
function M.start_lsp_client(server_name, bufnr, config)
    -- Use vim.lsp.start which handles client reuse automatically
    config.capabilities = require("blink.cmp").get_lsp_capabilities()

    return vim.lsp.start(config, {
        bufnr = bufnr,
        reuse_client = function(client, conf)
            return client.name == conf.name
        end,
    })
end

-- Get capabilities
function M.get_capabilities()
    return require("blink.cmp").get_lsp_capabilities()
end

return M
