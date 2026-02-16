local M = {}

-- Track reload state
M.is_reloading = false

-- List of LSP servers you use (hardcoded as requested)
M.lsp_servers = {
    "gopls",
    "lua_ls",
    "vtsls",
    "html",
    "cssls",
    "marksman",
    "roslyn",
}

-- Full reload function
function M.full_reload()
    if M.is_reloading then
        vim.notify("⚠️ Reload already in progress...", vim.log.levels.WARN)
        return
    end

    M.is_reloading = true
    local start_time = vim.loop.hrtime()

    vim.notify("🔄 Starting full LSP & CMP reload...", vim.log.levels.INFO)

    -- Step 1: Stop all LSP clients
    vim.notify("  ⏹️  Stopping LSP clients...", vim.log.levels.INFO)
    M.stop_all_lsp_clients()

    -- Step 2: Clear Lua module cache for LSP and CMP
    vim.notify("  🧹 Clearing module cache...", vim.log.levels.INFO)
    M.clear_module_cache()

    -- Step 3: Reload CMP
    vim.notify("  🔄 Reloading nvim-cmp...", vim.log.levels.INFO)
    local cmp_ok, cmp_err = pcall(M.reload_cmp)
    if not cmp_ok then
        vim.notify("  ❌ CMP reload failed: " .. tostring(cmp_err), vim.log.levels.ERROR)
    end

    -- Step 4: Reload LSP configs
    vim.notify("  🔄 Reloading LSP configurations...", vim.log.levels.INFO)
    M.reload_lsp_configs()

    -- Step 5: Re-attach to current buffer
    vim.notify("  🔌 Re-attaching to current buffer...", vim.log.levels.INFO)
    M.reattach_to_buffer(vim.api.nvim_get_current_buf())

    -- Step 6: Re-attach to other buffers
    vim.notify("  🔌 Re-attaching to other buffers...", vim.log.levels.INFO)
    M.reattach_to_all_buffers()

    -- Calculate time
    local elapsed = (vim.loop.hrtime() - start_time) / 1e6
    M.is_reloading = false

    vim.notify(string.format("✅ Reload complete! (%.2fms)", elapsed), vim.log.levels.INFO)
end

-- Stop all active LSP clients
function M.stop_all_lsp_clients()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients() or vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id, true)
    end
    -- Wait a bit for clients to stop
    vim.wait(100)
end

-- Clear Lua module cache for LSP and CMP related modules
function M.clear_module_cache()
    local modules_to_clear = {
        -- CMP modules
        "cmp",
        "cmp_nvim_lsp",
        "cmp_buffer",
        "cmp_path",
        "cmp_luasnip",
        "lspkind",

        -- LSP modules
        "lspconfig",
        "lspconfig.configs",
        "lspconfig.util",

        -- Your LSP configs
        "lsp.on_attach",
        "lsp.gopls",
        "lsp.lua-lsp",
        "lsp.vtsls",
        "lsp.html",
        "lsp.css",
        "lsp.markdown",
    }

    for _, mod in ipairs(modules_to_clear) do
        package.loaded[mod] = nil
    end
end

-- Reload CMP configuration
function M.reload_cmp()
    -- Clear CMP cache
    local cmp = require("cmp")
    cmp.close()

    -- Reload config
    package.loaded["plugins.nvim-cmp"] = nil
    require("plugins.nvim-cmp")

    -- Force re-attach to current buffer
    cmp.setup.buffer({})
end

-- Reload LSP configurations (only for active clients)
function M.reload_lsp_configs()
    -- Reload on_attach first
    package.loaded["lsp.on_attach"] = nil
    require("lsp.on_attach")

    -- Get currently active LSP clients and their names
    local active_clients = vim.lsp.get_clients and vim.lsp.get_clients() or vim.lsp.get_active_clients()
    local active_servers = {}
    for _, client in ipairs(active_clients) do
        active_servers[client.name] = true
    end

    -- Only reload configs for servers that are actually active
    for _, server in ipairs(M.lsp_servers) do
        if active_servers[server] then
            local config_module = "lsp." .. server:gsub("_", "-")
            package.loaded[config_module] = nil

            local ok, err = pcall(require, config_module)
            if not ok then
                vim.notify(string.format("  ⚠️ Failed to reload %s: %s", server, err), vim.log.levels.WARN)
            end
        end
    end
end

-- Re-attach LSP to specific buffer
function M.reattach_to_buffer(bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft == "" then return end

    -- Trigger LspAttach manually
    vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr })
end

-- Re-attach to all buffers
function M.reattach_to_all_buffers()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
            M.reattach_to_buffer(bufnr)
        end
    end
end

-- Individual reload commands
function M.reload_lsp_only()
    vim.notify("🔄 Reloading LSP only...", vim.log.levels.INFO)
    M.stop_all_lsp_clients()
    M.reload_lsp_configs()
    M.reattach_to_all_buffers()
    vim.notify("✅ LSP reload complete!", vim.log.levels.INFO)
end

function M.reload_cmp_only()
    vim.notify("🔄 Reloading CMP only...", vim.log.levels.INFO)
    M.clear_module_cache()
    M.reload_cmp()
    vim.notify("✅ CMP reload complete!", vim.log.levels.INFO)
end

return M
