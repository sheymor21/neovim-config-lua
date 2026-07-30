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

    -- Check notes vault
    vim.health.info("")
    vim.health.info("Notes Vault:")
    local paths = require("config.paths")
    local vault_path = paths.vault_path
    if vim.fn.isdirectory(vault_path) == 1 then
        vim.health.ok("Vault found at " .. vault_path)
    else
        vim.health.warn("Vault not found at " .. vault_path .. " - create it to use notes features")
    end

    -- Check Story Board (DiaProject)
    vim.health.info("")
    vim.health.info("Story Board:")
    local storyboard = require("config.storyboard")
    if vim.fn.executable("go") == 1 then
        vim.health.ok("Go is installed")
    else
        vim.health.warn("Go is not installed — needed to build Story Board")
    end
    if vim.fn.executable("curl") == 1 then
        vim.health.ok("curl is installed")
    else
        vim.health.error("curl is required but not installed")
    end
    if storyboard.is_cloned() then
        vim.health.ok("Story Board repo cloned at " .. storyboard.clone_dir)
    else
        vim.health.warn("Story Board not cloned — run <leader>dd to clone and start")
    end
    if storyboard.has_binary() then
        vim.health.ok("Story Board binary exists")
    elseif storyboard.is_cloned() then
        vim.health.warn("Story Board binary missing — will be built on first start")
    end
    if storyboard.is_running() then
        vim.health.ok("Story Board is running on port " .. (storyboard.get_port() or "?"))
    else
        vim.health.info("Story Board is not running")
    end
end

return M
