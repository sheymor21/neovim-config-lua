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

return M
