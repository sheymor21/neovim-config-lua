local dap = require("dap")
local dapui = require("dapui")
local map = vim.keymap.set

map("n", "<F5>", dap.continue, { desc = "DAP Start" })
map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

map("n", "<eader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })

map("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
map("n", "<leader>du", dapui.toggle, { desc = "DAP UI" })
map("n", "<leader>dx", dap.terminate, { desc = "DAP Stop" })
