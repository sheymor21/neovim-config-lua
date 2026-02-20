local M = {}

-- Start or attach to existing LSP client using built-in Neovim functionality
function M.start_lsp_client(server_name, bufnr, config)
    -- Use vim.lsp.start which handles client reuse automatically
    config.capabilities = require("cmp_nvim_lsp").default_capabilities()
    
    return vim.lsp.start(config, {
        bufnr = bufnr,
        reuse_client = function(client, conf)
            return client.name == conf.name
        end,
    })
end

-- Get capabilities
function M.get_capabilities()
    return require("cmp_nvim_lsp").default_capabilities()
end

return M
