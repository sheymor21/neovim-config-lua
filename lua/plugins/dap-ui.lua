return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.after.event_initialized["dapui"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui"] = function()
            dapui.close()
        end

        require("mason-nvim-dap").setup({
            automatic_installation = true,
            ensure_installed = {
                "netcoredbg",
                "js-debug-adapter",
                "delve",
            },
        })
    end,
}
