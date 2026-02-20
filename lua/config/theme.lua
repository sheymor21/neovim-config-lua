local M = {}

-- Cache for loaded themes
M.loaded_themes = {}

-- Cache lualine module
local lualine = nil
local function get_lualine()
    if not lualine then
        local ok, mod = pcall(require, "lualine")
        if ok then
            lualine = mod
        end
    end
    return lualine
end

local function apply_lualine(theme)
    local lual = get_lualine()
    if not lual then
        return
    end

    -- Only update theme option, don't full reconfigure
    local current_config = lual.get_config and lual.get_config() or {}
    if current_config.options and current_config.options.theme ~= theme then
        current_config.options.theme = theme
        lual.setup(current_config)
    end
end

M.current = nil

M.apply = function(name)
    if M.current == name then
        return
    end

    -- Load theme plugin only if not already loaded (non-blocking)
    if not M.loaded_themes[name] then
        require("lazy").load({
            plugins = { name },
            wait = false, -- Don't block!
        })
        M.loaded_themes[name] = true
    end

    -- Apply immediately without vim.schedule
    if vim.g.colors_name ~= name then
        local ok = pcall(vim.cmd.colorscheme, name)
        if not ok then
            vim.notify("Colorscheme not found: " .. name, vim.log.levels.WARN)
            return
        end
    end

    M.current = name
    apply_lualine(name)
end

return M
