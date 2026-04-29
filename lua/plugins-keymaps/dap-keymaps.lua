local map = vim.keymap.set

map("n", "<F5>", function() require("dap").continue() end, { desc = "DAP Start" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "DAP Step Over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "DAP Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "DAP Step Out" })


local function toggle_breakpoint_or_debugger()
    local ft = vim.bo.filetype
    if ft == "javascript" or ft == "typescript" then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        vim.api.nvim_buf_set_lines(0, row, row, false, { "debugger;" })
        print("Inserted 'debugger;' below current line")
    else
        require("dap").toggle_breakpoint()
    end
end

-- Mapeo
map("n", "<leader>ib", toggle_breakpoint_or_debugger, { desc = "Toggle Breakpoint / Debugger" })
map("n", "<leader>iB", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })

map("n", "<leader>cdr", function() require("dap").repl.open() end, { desc = "DAP REPL" })
map("n", "<leader>cdu", function() require("dapui").toggle() end, { desc = "DAP UI" })
map("n", "<leader>cdx", function() require("dap").terminate() end, { desc = "DAP Stop" })

-- C# specific debug keymaps
map("n", "<leader>cdd", function()
	if vim.bo.filetype ~= "cs" then
		vim.notify("Not a C# file", vim.log.levels.WARN)
		return
	end
	require("dap").continue()
end, { desc = "Debug .NET API" })

map("n", "<leader>cdt", function()
	if vim.bo.filetype ~= "cs" then
		vim.notify("Not a C# file", vim.log.levels.WARN)
		return
	end
	local dap = require("dap")
	local configs = dap.configurations.cs
	for _, config in ipairs(configs) do
		if config.name:match("Test") and config.name:match("Current") then
			dap.run(config)
			return
		end
	end
	vim.notify("Test configuration not found", vim.log.levels.ERROR)
end, { desc = "Debug NUnit Test (current file)" })

map("n", "<leader>cdT", function()
	if vim.bo.filetype ~= "cs" then
		vim.notify("Not a C# file", vim.log.levels.WARN)
		return
	end
	local dap = require("dap")
	local configs = dap.configurations.cs
	for _, config in ipairs(configs) do
		if config.name:match("All") then
			dap.run(config)
			return
		end
	end
	vim.notify("All tests configuration not found", vim.log.levels.ERROR)
end, { desc = "Debug All NUnit Tests" })
