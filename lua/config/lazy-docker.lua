local Terminal = require("toggleterm.terminal").Terminal

local lazydocker = Terminal:new({
  cmd = "lazydocker",
  hidden = true,
  direction = "float",
  float_opts = { border = "rounded" },
})

local M = {}

local function command_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

function M.toggle()
  if not command_exists("lazydocker") then
    vim.notify("LazyDocker no está instalado", vim.log.levels.ERROR)
    return
  end
  lazydocker:toggle()
end

return M
