return {
    "nvim-neotest/neotest",
    cmd = { "Neotest", "NeotestSummary" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/nvim-nio",

        -- Necesario para cursorhold estable
        "antoinemadec/FixCursorHold.nvim",

        -- Adapters
        "nvim-neotest/neotest-plenary",

        -- DAP
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        local ok, neotest = pcall(require, "neotest")
        if not ok then
            return
        end

        -- Adapters
        local adapters = {}

        local ok_plenary, plenary = pcall(require, "neotest-plenary")
        if ok_plenary then
            table.insert(adapters, plenary({
                min_init = "tests/minimal_init.lua",
                filetypes = { "lua" },
            }))
        end

        local neotest_config = {
            adapters = adapters,

            log_level = vim.log.levels.WARN,

            -- === DISCOVERY / RUNNING ===
            discovery = {
                enabled = true,
                concurrent = 4,
            },

            running = {
                concurrent = true,
            },

            -- === OUTPUT ===
            summary = {
                enabled = true,
                expand_errors = true,
                follow = true,
            },

            -- === DIAGNOSTICS ===
            diagnostics = {
                enabled = true,
                severity = vim.diagnostic.severity.ERROR,
            },

            -- === STATUS ===
            status = {
                enabled = true,
                signs = true,
                virtual_text = false,
            },

            icons = {
                running = "",
                passed = "",
                failed = "",
                skipped = "",
                unknown = "",
            },

            default_strategy = "integrated",

            strategies = {
                integrated = {
                    width = 120,
                },
                dap = {
                    -- deja que dap use su propia config
                    justMyCode = false,
                },
            },

            quickfix = {
                enabled = false,
            },

        }

        neotest.setup(neotest_config)

        -- === DAP UI AUTO ===
        local dap_ok, dap = pcall(require, "dap")
        local dapui_ok, dapui = pcall(require, "dapui")

        if dap_ok and dapui_ok then
            dapui.setup()

            dap.listeners.after.event_initialized["neotest-dap-ui"] = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated["neotest-dap-ui"] = function()
                dapui.close()
            end

            dap.listeners.before.event_exited["neotest-dap-ui"] = function()
                dapui.close()
            end
        end
    end,
}
