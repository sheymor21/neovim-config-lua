-- Performance profiling and utilities
local M = {}

-- Track startup timing
local start_time = vim.loop.hrtime()

function M.get_startup_time()
    local elapsed = vim.loop.hrtime() - start_time
    return elapsed / 1e6 -- Convert to milliseconds
end

-- Profile startup time
vim.api.nvim_create_user_command("StartupTime", function()
    local stats = require("lazy").stats()
    print(string.format("Startup time: %.2fms", stats.startuptime))
    print(string.format("Plugins loaded: %d/%d", stats.loaded, stats.count))
end, { desc = "Show startup time" })

-- Show slow plugins
vim.api.nvim_create_user_command("SlowPlugins", function()
    local stats = require("lazy").stats()
    local plugins = {}
    
    -- Check if stats.plugins exists
    if not stats.plugins then
        print("No plugin timing data available yet.")
        print("Try running this command after Neovim has fully started.")
        return
    end
    
    for name, plugin in pairs(stats.plugins) do
        if plugin.time and plugin.time > 5 then
            table.insert(plugins, { name = name, time = plugin.time })
        end
    end
    
    table.sort(plugins, function(a, b) return a.time > b.time end)
    
    if #plugins == 0 then
        print("No slow plugins found (all loaded in <5ms)")
    else
        print("Slow plugins (>5ms):")
        for _, plugin in ipairs(plugins) do
            print(string.format("  %s: %.2fms", plugin.name, plugin.time))
        end
    end
end, { desc = "Show slow loading plugins" })

-- Check if something failed during startup
function M.check_errors()
    local errors = {}
    
    -- Check for plugin errors
    local ok, lazy = pcall(require, "lazy")
    if ok then
        local plugins_ok, plugins = pcall(lazy.plugins)
        if plugins_ok and plugins then
            for _, plugin in pairs(plugins) do
                if plugin._ and plugin._.error then
                    table.insert(errors, {
                        type = "plugin",
                        name = plugin.name,
                        error = plugin._.error
                    })
                end
            end
        end
    end
    
    -- Check for LSP errors (using non-deprecated API)
    local clients_ok, clients = pcall(function()
        return vim.lsp.get_clients and vim.lsp.get_clients() or vim.lsp.get_active_clients()
    end)
    if clients_ok and clients then
        for _, client in ipairs(clients) do
            if client.is_stopped and client.is_stopped() then
                table.insert(errors, {
                    type = "lsp",
                    name = client.name,
                    error = "LSP client stopped unexpectedly"
                })
            end
        end
    end
    
    return errors
end

-- Notify about errors
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.defer_fn(function()
            local errors = M.check_errors()
            if #errors > 0 then
                vim.notify(
                    string.format("⚠️ %d errors detected during startup! Run :CheckHealth for details", #errors),
                    vim.log.levels.WARN
                )
            end
        end, 1000)
    end,
})

return M
