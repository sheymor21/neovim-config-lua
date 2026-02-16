local M = {}

-- Check if command exists
function M.command_exists(cmd)
    return vim.fn.executable(cmd) == 1
end

-- Standardized notification
function M.notify(msg, level, opts)
    opts = opts or {}
    if pcall(require, "noice") then
        vim.schedule(function()
            require("noice").notify(msg, level, opts)
        end)
    else
        vim.notify(msg, level, opts)
    end
end

-- Entry filter for nvim-cmp (hides completion when typing ~)
function M.cmp_entry_filter(entry, ctx)
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local before_cursor = line:sub(1, col)
    if before_cursor:match("~[^%s]*$") then
        return false
    end
    return true
end

return M
