local Terminal = require("toggleterm.terminal").Terminal
local utils = require("utils")

local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "rounded",
    },
})

local M = {}

function M.toggle()
    if not utils.command_exists("lazygit") then
        utils.notify("LazyGit no está instalado", vim.log.levels.ERROR)
        return
    end
    lazygit:toggle()
end

return M
