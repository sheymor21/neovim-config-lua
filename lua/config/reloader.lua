local M = {}

M.is_reloading = false

local STOP_TIMEOUT_MS = 5000
local STOP_POLL_INTERVAL_MS = 50

---Collect all LSP-related module names that should be cleared on reload.
local function collect_modules()
    local servers = require("lsp.servers")
    local modules = {
        "lsp.servers",
        "lsp.setup",
        "lsp.utils",
        "lsp.on_attach",
    }

    for _, server in ipairs(servers.servers) do
        table.insert(modules, server.module)
    end

    return modules
end

---Clear the Lua module cache for the given modules.
local function clear_module_cache(modules)
    for _, mod in ipairs(modules) do
        package.loaded[mod] = nil
    end
end

---Return a set of server names managed by our registry.
local function get_managed_servers()
    local servers = require("lsp.servers")
    local managed = {}
    for _, server in ipairs(servers.servers) do
        managed[server.name] = true
    end
    return managed
end

---Stop only the LSP clients managed by our registry and wait until they are gone.
local function stop_all_clients()
    local managed = get_managed_servers()
    local clients = vim.lsp.get_clients()
    local stopped_any = false

    for _, client in ipairs(clients) do
        if managed[client.name] then
            client:stop(true)
            stopped_any = true
        end
    end

    if not stopped_any then
        return true
    end

    local ok = vim.wait(STOP_TIMEOUT_MS, function()
        for _, client in ipairs(vim.lsp.get_clients()) do
            if managed[client.name] then
                return false
            end
        end
        return true
    end, STOP_POLL_INTERVAL_MS)

    return ok
end

---Stop all clients for a specific server and wait until they are gone.
---@param server_name string
local function stop_clients_by_name(server_name)
    local clients = vim.lsp.get_clients({ name = server_name })

    for _, client in ipairs(clients) do
        client:stop(true)
    end

    if #clients == 0 then
        return true
    end

    local ok = vim.wait(STOP_TIMEOUT_MS, function()
        return #vim.lsp.get_clients({ name = server_name }) == 0
    end, STOP_POLL_INTERVAL_MS)

    return ok
end

---Re-trigger FileType autocmds for all loaded buffers.
local function reattach_to_all_buffers()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype ~= "" then
            vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr })
        end
    end
end

---Re-trigger FileType autocmds for buffers matching one of the given filetypes.
---@param filetypes string[]
local function reattach_to_matching_buffers(filetypes)
    local ft_set = {}
    for _, ft in ipairs(filetypes) do
        ft_set[ft] = true
    end

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local ft = vim.bo[bufnr].filetype
        if vim.api.nvim_buf_is_loaded(bufnr) and ft ~= "" and ft_set[ft] then
            vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr })
        end
    end
end

---Reload all LSP configs and re-register autocmds.
local function reload_all_configs()
    local setup = require("lsp.setup")

    setup.clear_autocmds()
    setup.setup()
end

---Reload a single LSP config and re-register its autocmd.
---@param module string
local function reload_config(module)
    local setup = require("lsp.setup")
    local ok, config = pcall(require, module)

    if not ok then
        vim.notify("Failed to reload LSP config " .. module .. ": " .. tostring(config), vim.log.levels.ERROR)
        return nil
    end

    setup.register_server(config)
    return config
end

---Reload a specific LSP server.
---@param server_name string
function M.reload_server(server_name)
    if M.is_reloading then
        vim.notify("LSP reload already in progress", vim.log.levels.WARN)
        return
    end

    local servers = require("lsp.servers")
    local entry = servers.get(server_name)

    if not entry then
        vim.notify("Unknown LSP server: " .. server_name, vim.log.levels.ERROR)
        return
    end

    M.is_reloading = true
    local start_time = vim.uv.hrtime()

    vim.notify("Reloading LSP server: " .. server_name, vim.log.levels.INFO)

    stop_clients_by_name(server_name)

    -- Clear cache for the server and shared helpers.
    package.loaded[entry.module] = nil
    package.loaded["lsp.on_attach"] = nil
    package.loaded["lsp.utils"] = nil

    -- Remove the old FileType autocmd for this server before re-registering.
    require("lsp.setup").clear_server_autocmds(server_name)

    local config = reload_config(entry.module)

    if config then
        reattach_to_matching_buffers(config.filetypes)
    end

    local elapsed = (vim.uv.hrtime() - start_time) / 1e6
    M.is_reloading = false

    if config then
        vim.notify(string.format("LSP server '%s' reloaded (%.2fms)", server_name, elapsed), vim.log.levels.INFO)
    else
        vim.notify(string.format("Failed to reload LSP server '%s' (%.2fms)", server_name, elapsed), vim.log.levels.ERROR)
    end
end

---Full reload: stop all clients, clear module cache, reload configs, reattach.
function M.full_reload()
    if M.is_reloading then
        vim.notify("LSP reload already in progress", vim.log.levels.WARN)
        return
    end

    M.is_reloading = true
    local start_time = vim.uv.hrtime()

    vim.notify("Reloading LSP...", vim.log.levels.INFO)

    stop_all_clients()
    clear_module_cache(collect_modules())
    reload_all_configs()
    reattach_to_all_buffers()

    local elapsed = (vim.uv.hrtime() - start_time) / 1e6
    M.is_reloading = false

    vim.notify(string.format("LSP reloaded (%.2fms)", elapsed), vim.log.levels.INFO)
end

---Alias for full reload.
function M.reload_lsp_only()
    M.full_reload()
end

return M
