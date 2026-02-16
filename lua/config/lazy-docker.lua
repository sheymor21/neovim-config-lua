local Terminal = require("toggleterm.terminal").Terminal
local utils = require("utils")

local lazydocker = Terminal:new({
    cmd = "lazydocker",
    hidden = true,
    direction = "float",
    float_opts = { border = "rounded" },
})

local M = {}

function M.toggle()
    if not utils.command_exists("lazydocker") then
        utils.notify("LazyDocker no está instalado", vim.log.levels.ERROR)
        return
    end
    lazydocker:toggle()
end

return M
