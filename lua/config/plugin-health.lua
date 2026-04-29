-- Plugin health monitor for long sessions
-- Detects and recovers from plugin state degradation

local M = {}

-- Track last known good state
local plugin_states = {
    which_key = { last_check = 0, healthy = true },
    blink = { last_check = 0, healthy = true },
}

-- Check if which-key is responsive
local function check_which_key()
    local ok, wk = pcall(require, "which-key")
    if not ok then
        return false, "which-key not loaded"
    end
    
    -- Try to access which-key state
    local state_ok = pcall(function()
        -- which-key should have a show function
        return type(wk.show) == "function"
    end)
    
    if not state_ok then
        return false, "which-key state corrupted"
    end
    
    return true, "healthy"
end

-- Check if blink.cmp is responsive
local function check_blink()
    local ok, blink = pcall(require, "blink.cmp")
    if not ok then
        return false, "blink.cmp not loaded"
    end

    -- Try to access blink state
    local state_ok = pcall(function()
        -- blink should have show and hide functions
        return type(blink.show) == "function" and type(blink.hide) == "function"
    end)

    if not state_ok then
        return false, "blink.cmp state corrupted"
    end

    -- Check if sources are configured
    local config_ok, config = pcall(function()
        return blink.config and blink.config.sources
    end)

    if config_ok and config then
        local has_sources = config.default and #config.default > 0
        if not has_sources then
            return false, "blink.cmp sources not configured"
        end
    end

    return true, "healthy"
end

-- Attempt to reload a plugin
local function reload_plugin(name)
    -- Unload the module
    package.loaded[name] = nil
    -- Clear all submodules
    for mod_name, _ in pairs(package.loaded) do
        if mod_name:match("^" .. name:gsub("%-", "%%-") .. "$") or 
           mod_name:match("^" .. name:gsub("%-", "%%-") .. "%.") then
            package.loaded[mod_name] = nil
        end
    end
    
    -- Try to reload
    local ok, err = pcall(require, name)
    if ok then
        vim.notify(string.format("Reloaded %s", name), vim.log.levels.INFO)
        return true
    else
        vim.notify(string.format("Failed to reload %s: %s", name, err), vim.log.levels.ERROR)
        return false
    end
end

-- Perform health check
function M.check_health()
    local current_time = vim.uv.now()
    local issues = {}
    
    -- Check which-key (only every 30 seconds)
    if current_time - plugin_states.which_key.last_check > 30000 then
        local healthy, msg = check_which_key()
        plugin_states.which_key.last_check = current_time
        plugin_states.which_key.healthy = healthy
        
        if not healthy then
            table.insert(issues, { plugin = "which-key", msg = msg })
            -- Try to reload
            reload_plugin("which-key")
        end
    end
    
    -- Check blink.cmp (only every 30 seconds)
    if current_time - plugin_states.blink.last_check > 30000 then
        local healthy, msg = check_blink()
        plugin_states.blink.last_check = current_time
        plugin_states.blink.healthy = healthy

        if not healthy then
            table.insert(issues, { plugin = "blink.cmp", msg = msg })
            -- Try to reload
            reload_plugin("blink.cmp")
        end
    end
    
    return issues
end

-- Setup periodic health checks
function M.setup()
    -- Check every 5 minutes during long sessions
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        callback = function()
            local uptime = vim.uv.uptime() -- seconds since nvim started
            -- Only start monitoring after 30 minutes of uptime
            if uptime > 1800 then
                M.check_health()
            end
        end,
    })
    
    -- User command to manually check health
    vim.api.nvim_create_user_command("PluginHealth", function()
        local issues = M.check_health()
        if #issues == 0 then
            vim.notify("All plugins healthy", vim.log.levels.INFO)
        else
            for _, issue in ipairs(issues) do
                vim.notify(string.format("%s: %s", issue.plugin, issue.msg), vim.log.levels.WARN)
            end
        end
    end, { desc = "Check plugin health" })
end

-- Initialize
M.setup()

return M
