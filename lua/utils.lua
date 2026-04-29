local M = {}

-- Check if command exists
function M.command_exists(cmd)
    return vim.fn.executable(cmd) == 1
end

-- Standardized notification (uses nvim-notify via vim.notify)
function M.notify(msg, level, opts)
    vim.notify(msg, level, opts or {})
end

return M
