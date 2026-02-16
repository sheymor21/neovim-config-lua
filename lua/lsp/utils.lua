local M = {}

-- Cache for LSP client IDs
M.client_cache = {}

-- Start or attach to existing LSP client
function M.start_lsp_client(server_name, bufnr, config)
    local cache_key = server_name .. "_" .. vim.fn.getcwd()
    local client_id = M.client_cache[cache_key]
    
    if client_id then
        local client = vim.lsp.get_client_by_id(client_id)
        if client then
            vim.lsp.buf_attach_client(bufnr, client_id)
            return client_id
        else
            M.client_cache[cache_key] = nil
        end
    end
    
    -- Create new client
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    config.capabilities = capabilities
    
    client_id = vim.lsp.start(config, {
        bufnr = bufnr,
        reuse_client = function(client, conf)
            return client.name == conf.name
        end,
    })
    
    if client_id then
        M.client_cache[cache_key] = client_id
    end
    
    return client_id
end

-- Get capabilities (cached)
local cached_capabilities = nil
function M.get_capabilities()
    if not cached_capabilities then
        cached_capabilities = require("cmp_nvim_lsp").default_capabilities()
    end
    return cached_capabilities
end

return M
