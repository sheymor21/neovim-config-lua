local dap = require("dap")
local dapui = require("dapui")
local map = vim.keymap.set

map("n", "<F5>", dap.continue, { desc = "DAP Start" })
map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })


local function toggle_breakpoint_or_debugger()
    local ft = vim.bo.filetype
    if ft == "javascript" or ft == "typescript" then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "debugger;" })
        print("Inserted 'debugger;' below current line")
    else
        dap.toggle_breakpoint()
    end
end

-- Mapeo
map("n", "<leader>ib", toggle_breakpoint_or_debugger, { desc = "Toggle Breakpoint / Debugger" })
map("n", "<leader>iB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })

map("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
map("n", "<leader>du", dapui.toggle, { desc = "DAP UI" })
map("n", "<leader>dx", dap.terminate, { desc = "DAP Stop" })
