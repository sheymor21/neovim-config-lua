local dap = require("dap")

local mason_path = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"

dap.adapters.coreclr = {
  type = "executable",
  command = mason_path,
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch .NET",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}
