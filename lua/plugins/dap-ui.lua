return {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut", "DapTerminate", "DapToggleRepl" },
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Enhanced DAP UI setup
        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
            controls = {
                icons = {
                    pause = "",
                    play = "",
                    step_into = "",
                    step_over = "",
                    step_out = "",
                    step_back = "",
                    run_last = "↻",
                    terminate = "",
                    disconnect = "",
                },
            },
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.25 },
                        { id = "breakpoints", size = 0.25 },
                        { id = "stacks", size = 0.25 },
                        { id = "watches", size = 0.25 },
                    },
                    size = 40,
                    position = "left",
                },
                {
                    elements = {
                        { id = "repl", size = 0.5 },
                        { id = "console", size = 0.5 },
                    },
                    size = 0.25,
                    position = "bottom",
                },
            },
        })

        -- Virtual text for DAP
        require("nvim-dap-virtual-text").setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            virt_text_pos = "eol",
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
        })

        -- Shared function for auto open/close dapui (exported for use by other plugins)
        _G.setup_dapui_auto_open_close = function(listener_name)
            dap.listeners.after.event_initialized[listener_name] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated[listener_name] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited[listener_name] = function()
                dapui.close()
            end
        end

        -- Setup auto open/close for dap-ui itself
        _G.setup_dapui_auto_open_close("dapui_config")

        -- Error handling for DAP
        dap.listeners.after["event_output"]["error_handler"] = function(session, body)
            if body.category == "stderr" then
                vim.notify("DAP Error: " .. body.output, vim.log.levels.ERROR)
            end
        end

        -- Mason-nvim-dap setup (only if mason is available)
        local ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
        if ok then
            mason_nvim_dap.setup({
                automatic_installation = true,
                ensure_installed = {
                    "netcoredbg",
                    "js-debug-adapter",
                    "delve",
                },
            })
        end
    end,
}
