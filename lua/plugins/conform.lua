return {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- Lua
                lua = { "stylua" },

                -- Python
                python = { "black" },

                -- Go
                go = { "gofumpt", "goimports" },

                -- C#
                cs = { "csharpier" },

                -- Web technologies (Prettier with LSP fallback)
                javascript = { "prettier", "vtsls" },
                typescript = { "prettier", "vtsls" },
                javascriptreact = { "prettier", "vtsls" },
                typescriptreact = { "prettier", "vtsls" },
                json = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },

                -- Shell
                sh = { "shfmt" },
                bash = { "shfmt" },
            },

            -- Format on save: DISABLED (manual only)
            format_on_save = false,

            stop_after_first = true,

            formatters = {
                prettier = {
                    prepend_args = function(self, ctx)
                        local prettier_configs = {
                            ".prettierrc", ".prettierrc.json", ".prettierrc.yml",
                            ".prettierrc.yaml", ".prettierrc.js", "prettier.config.js",
                        }

                        for _, config in ipairs(prettier_configs) do
                            if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. config) == 1 then
                                return {}
                            end
                        end

                        -- Spacious defaults (not tight!)
                        return {
                            "--tab-width", "4",
                            "--use-tabs", "false",
                            "--semi", "true",
                            "--single-quote", "false",
                            "--print-width", "120",
                            "--trailing-comma", "es5",
                            "--bracket-spacing", "true",
                            "--arrow-parens", "always",
                            "--end-of-line", "lf",
                        }
                    end,
                },
                stylua = {
                    prepend_args = {
                        "--indent-width", "4",
                        "--indent-type", "Spaces",
                        "--column-width", "100",
                        "--line-endings", "Unix",
                    },
                },
                black = {
                    prepend_args = { "--line-length", "100" },
                },
                shfmt = {
                    prepend_args = { "-i", "4", "-ci", "-bn" },
                },
            },

            notify = function(msg, level)
                if pcall(require, "noice") then
                    vim.schedule(function()
                        require("noice").notify(msg, level)
                    end)
                else
                    vim.notify(msg, level)
                end
            end,
        })
    end,
}
