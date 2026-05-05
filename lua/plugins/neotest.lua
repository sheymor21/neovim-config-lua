return {
    "nvim-neotest/neotest",
    cmd = { "Neotest", "NeotestSummary" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/nvim-nio",

        -- Required for stable cursorhold
        "antoinemadec/FixCursorHold.nvim",

        -- Adapters
        "nvim-neotest/neotest-plenary",
        "nsidorenco/neotest-vstest",

        -- DAP
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        -- Configure neotest-vstest (must be set before requiring)
        vim.g.neotest_vstest = {
            dap_settings = {
                type = "coreclr",
            },
        }

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

        local ok_vstest, vstest = pcall(require, "neotest-vstest")
        if ok_vstest then
            table.insert(adapters, vstest)
        end


        local neotest_config = {
            adapters = adapters,

            log_level = vim.log.levels.DEBUG,

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
                    -- let dap use its own config
                    justMyCode = false,
                },
            },

            quickfix = {
                enabled = false,
            },

        }

        neotest.setup(neotest_config)

        -- === DAP UI AUTO ===
        -- Use shared setup function from dap-ui plugin
        if _G.setup_dapui_auto_open_close then
            _G.setup_dapui_auto_open_close("neotest-dap-ui")
        end
    end,
}
