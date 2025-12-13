local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "rounded",
  },
})

local M = {}

local function command_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

function M.toggle()
  if not command_exists("lazygit") then
    vim.notify("LazyGit no está instalado", vim.log.levels.ERROR)
    return
  end
  lazygit:toggle()
end

return M
