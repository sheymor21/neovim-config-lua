local M = {}

function M.check()
    vim.health.start("Neovim Configuration Health Check")
    
    -- Check startup time
    local stats = require("lazy").stats()
    vim.health.info("Startup Performance:")
    if stats.startuptime < 100 then
        vim.health.ok(string.format("Startup time: %.2fms (excellent)", stats.startuptime))
    elseif stats.startuptime < 150 then
        vim.health.ok(string.format("Startup time: %.2fms (good)", stats.startuptime))
    elseif stats.startuptime < 200 then
        vim.health.warn(string.format("Startup time: %.2fms (acceptable)", stats.startuptime))
    else
        vim.health.error(string.format("Startup time: %.2fms (too slow!)", stats.startuptime))
    end
    vim.health.info(string.format("Plugins loaded: %d/%d", stats.loaded, stats.count))
    
    -- Check external dependencies
    vim.health.info("")
    vim.health.info("External Dependencies:")
    local deps = {
        { name = "git", cmd = "git", required = true },
        { name = "node", cmd = "node", required = false },
        { name = "npm", cmd = "npm", required = false },
        { name = "deno", cmd = "deno", required = false },
        { name = "go", cmd = "go", required = false },
        { name = "python3", cmd = "python3", required = false },
        { name = "dotnet", cmd = "dotnet", required = false },
        { name = "cargo", cmd = "cargo", required = false },
    }
    
    for _, dep in ipairs(deps) do
        if vim.fn.executable(dep.cmd) == 1 then
            vim.health.ok(dep.name .. " is installed")
        elseif dep.required then
            vim.health.error(dep.name .. " is required but not installed")
        else
            vim.health.warn(dep.name .. " is not installed (optional)")
        end
    end
    
    -- Check LSP servers
    vim.health.info("")
    vim.health.info("LSP Servers:")
    local lsp_servers = { "lua_ls", "gopls", "vtsls", "html", "cssls", "jsonls" }
    local lspconfig = require("lspconfig")
    
    for _, server in ipairs(lsp_servers) do
        if lspconfig[server] then
            vim.health.ok(server .. " is configured")
        else
            vim.health.warn(server .. " is not configured")
        end
    end
    
    -- Check for errors
    vim.health.info("")
    vim.health.info("Error Check:")
    local profiler = require("config.profiler")
    local errors = profiler.check_errors()
    
    if #errors == 0 then
        vim.health.ok("No errors detected")
    else
        for _, err in ipairs(errors) do
            vim.health.error(string.format("%s: %s - %s", err.type, err.name, err.error))
        end
    end
    
    -- Check plugin health
    vim.health.info("")
    vim.health.info("Plugin Health:")
    local lazy = require("lazy")
    local failed_plugins = {}
    
    for name, plugin in pairs(lazy.plugins()) do
        if plugin._.error then
            table.insert(failed_plugins, name)
        end
    end
    
    if #failed_plugins == 0 then
        vim.health.ok("All plugins loaded successfully")
    else
        for _, name in ipairs(failed_plugins) do
            vim.health.error("Plugin failed to load: " .. name)
        end
    end
end

return M
