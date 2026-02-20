local dap = require("dap")

local mason_path = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"

-- Helper function to find .csproj files
local function find_csproj_files()
	local cwd = vim.fn.getcwd()
	local handle = io.popen('find "' .. cwd .. '" -maxdepth 2 -name "*.csproj" -type f 2>/dev/null')
	if not handle then
		return {}
	end

	local projects = {}
	for line in handle:lines() do
		table.insert(projects, line)
	end
	handle:close()
	return projects
end

-- Helper function to get project name from .csproj path
local function get_project_name(csproj_path)
	return vim.fn.fnamemodify(csproj_path, ":t:r")
end

-- Helper function to find the DLL path for a project
local function find_dll_path(csproj_path)
	local project_name = get_project_name(csproj_path)
	local project_dir = vim.fn.fnamemodify(csproj_path, ":h")

	-- Try to find the target framework from the csproj
	local target_framework = nil
	local csproj_file = io.open(csproj_path, "r")
	if csproj_file then
		local content = csproj_file:read("*all")
		csproj_file:close()
		-- Look for <TargetFramework>netX.X</TargetFramework>
		target_framework = content:match("<TargetFramework>(net[%d%.]+)</TargetFramework>")
			or content:match("<TargetFrameworks>(net[%d%.]+)")
	end

	-- Build the DLL path
	local dll_path
	if target_framework then
		dll_path = project_dir .. "/bin/Debug/" .. target_framework .. "/" .. project_name .. ".dll"
	else
		-- Fallback: try to find any DLL in bin/Debug
		dll_path = project_dir .. "/bin/Debug/" .. project_name .. ".dll"
	end

	return dll_path
end

-- Helper function to find the startup project from .sln file
local function find_startup_project()
	local cwd = vim.fn.getcwd()
	local sln_files = vim.fn.glob(cwd .. "/*.sln", false, true)

	if #sln_files == 0 then
		return nil
	end

	-- Read the solution file to find the first project (usually the startup project)
	local sln_file = io.open(sln_files[1], "r")
	if not sln_file then
		return nil
	end

	local content = sln_file:read("*all")
	sln_file:close()

	-- Parse Project("{...}") = "ProjectName", "Path\To\Project.csproj", ...
	-- Note: csproj_path already includes the .csproj extension in the solution file
	for project_name, csproj_path in content:gmatch('Project%("[^"]+"%) = "([^"]+)", "([^"]+)"') do
		-- Return the first non-test project
		if not project_name:match("[Tt]est") then
			-- Convert backslash to forward slash and construct full path
			local full_path = vim.fn.fnamemodify(sln_files[1], ":h") .. "/" .. csproj_path:gsub("\\", "/")
			return full_path
		end
	end

	return nil
end

-- Helper function to select project interactively
local function select_project()
	local projects = find_csproj_files()

	if #projects == 0 then
		vim.notify("No .csproj files found in current directory", vim.log.levels.ERROR)
		return nil
	end

	if #projects == 1 then
		return projects[1]
	end

	-- Multiple projects - let user choose
	local project_names = {}
	for i, proj in ipairs(projects) do
		project_names[i] = get_project_name(proj)
	end

	vim.ui.select(project_names, {
		prompt = "Select project to debug:",
	}, function(choice, idx)
		if choice and idx then
			return projects[idx]
		end
	end)

	-- Fallback: return first project if selection cancelled
	return projects[1]
end

dap.adapters.coreclr = {
	type = "executable",
	command = mason_path,
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Launch .NET API (Auto-detect)",
		request = "launch",
		program = function()
			-- Try to find startup project from solution
			local startup = find_startup_project()
			if startup then
				local dll = find_dll_path(startup)
				if vim.fn.filereadable(dll) == 1 then
					return dll
				end
			end

			-- Fallback: select project interactively
			local project = select_project()
			if project then
				local dll = find_dll_path(project)
				-- Check if DLL exists, if not suggest building
				if vim.fn.filereadable(dll) == 0 then
					vim.notify("DLL not found. Run 'dotnet build' first!", vim.log.levels.WARN)
				end
				return dll
			end

		-- Last resort: manual input
		return vim.fn.input("DLL path: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
	end,
	cwd = function()
		-- Set working directory to project root (where .csproj is), not bin/Debug
		local startup = find_startup_project()
		if startup then
			return vim.fn.fnamemodify(startup, ":h")
		end
		local project = select_project()
		if project then
			return vim.fn.fnamemodify(project, ":h")
		end
		return vim.fn.getcwd()
	end,
	env = {
		ASPNETCORE_ENVIRONMENT = "Development",
		DOTNET_ENVIRONMENT = "Development",
	},
	console = "internalConsole",
	stopAtEntry = false,
},
{
	type = "coreclr",
	name = "Launch .NET (Manual Selection)",
	request = "launch",
	program = function()
		local project = select_project()
		if project then
			return find_dll_path(project)
		end
		return vim.fn.input("DLL path: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
	end,
	cwd = function()
		local project = select_project()
		if project then
			return vim.fn.fnamemodify(project, ":h")
		end
		return vim.fn.getcwd()
	end,
	env = {
		ASPNETCORE_ENVIRONMENT = "Development",
		DOTNET_ENVIRONMENT = "Development",
	},
	console = "internalConsole",
	stopAtEntry = false,
},
	{
		type = "coreclr",
		name = "Debug NUnit Test (Current File)",
		request = "launch",
		program = function()
			-- Find the test project
			local projects = find_csproj_files()
			local test_project = nil

			for _, proj in ipairs(projects) do
				if proj:match("[Tt]est") then
					test_project = proj
					break
				end
			end

			if test_project then
				local dll = find_dll_path(test_project)
				if vim.fn.filereadable(dll) == 0 then
					vim.notify("Test DLL not found. Run 'dotnet build' first!", vim.log.levels.WARN)
				end
				return dll
			end

		vim.notify("No test project found (looking for *test*.csproj)", vim.log.levels.ERROR)
		return nil
	end,
	cwd = function()
		local projects = find_csproj_files()
		for _, proj in ipairs(projects) do
			if proj:match("[Tt]est") then
				return vim.fn.fnamemodify(proj, ":h")
			end
		end
		return vim.fn.getcwd()
	end,
	args = function()
		-- Get the current test method name if possible
		local current_file = vim.fn.expand("%:t:r")
		return {
			"--filter",
			"FullyQualifiedName~" .. current_file,
		}
	end,
	env = {
		ASPNETCORE_ENVIRONMENT = "Development",
		DOTNET_ENVIRONMENT = "Development",
	},
	console = "internalConsole",
	stopAtEntry = false,
},
{
	type = "coreclr",
	name = "Debug All NUnit Tests",
	request = "launch",
	program = function()
		local projects = find_csproj_files()
		local test_project = nil

		for _, proj in ipairs(projects) do
			if proj:match("[Tt]est") then
				test_project = proj
				break
			end
		end

		if test_project then
			return find_dll_path(test_project)
		end

		vim.notify("No test project found", vim.log.levels.ERROR)
		return nil
	end,
	cwd = function()
		local projects = find_csproj_files()
		for _, proj in ipairs(projects) do
			if proj:match("[Tt]est") then
				return vim.fn.fnamemodify(proj, ":h")
			end
		end
		return vim.fn.getcwd()
	end,
	env = {
		ASPNETCORE_ENVIRONMENT = "Development",
		DOTNET_ENVIRONMENT = "Development",
	},
	console = "internalConsole",
	stopAtEntry = false,
},
}

dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug (arguments)",
		request = "launch",
		program = "${file}",
		args = function()
			local args_string = vim.fn.input("Arguments: ")
			return vim.split(args_string, " +")
		end,
	},
	{
		type = "go",
		name = "Debug Package",
		request = "launch",
		program = "${workspaceFolder}",
	},
	{
		type = "go",
		name = "Debug Test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
	{
		type = "go",
		name = "Attach (Pick Process)",
		mode = "local",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Debug with tsx",
		runtimeExecutable = "bunx",
		runtimeArgs = { "tsx" },
		args = { "${file}" },
		cwd = "${workspaceFolder}",
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		killBehavior = "forceful",
	},
}

dap.configurations.javascript = {
	type = "pwa-node",
	request = "launch",
	name = "Debug Node",
	runtimeExecutable = "node",
	program = "${file}",
	cwd = "${workspaceFolder}",
	sourceMaps = true,
	protocol = "inspector",
	console = "integratedTerminal",
}

-- Add keymaps for C# debugging (global, only work in C# files)
local map = vim.keymap.set

-- Debug current project (auto-detect)
map("n", "<leader>dd", function()
	if vim.bo.filetype ~= "cs" then
		vim.notify("Not a C# file", vim.log.levels.WARN)
		return
	end
	require("dap").continue()
end, { desc = "Debug .NET API" })

-- Debug test (current file)
map("n", "<leader>dt", function()
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

-- Debug all tests
map("n", "<leader>dT", function()
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
