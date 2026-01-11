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
            local cwd = vim.fn.getcwd()
            local default = cwd .. "/bin/Debug/"
            return vim.fn.input("DLL path: ", default, "file")
        end,
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
