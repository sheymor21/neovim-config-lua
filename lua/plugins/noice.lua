return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },

    opts = {
        -- Noice handles: cmdline, lsp hover/signature/progress, messages
        -- nvim-notify handles: vim.notify notifications

        messages = {
            enabled = true,
            view = "mini",
            view_error = "mini",
            view_warn = "mini",
            view_history = "messages",
        },

        lsp = {
            progress = {
                enabled = true,
                view = "mini",
            },

            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },

            hover = {
                enabled = true,
                silent = true,
                opts = { focusable = true, border = "rounded" },
            },

            signature = {
                enabled = true,
            },

            message = {
                enabled = true,
            },
        },

        -- Disable noice's vim.notify override (nvim-notify handles this)
        notify = {
            enabled = false,
        },

        views = {
            mini = {
                position = {
                    row = -2,
                    col = "100%",
                },
                size = {
                    width = 40,
                    height = "auto",
                },
                border = {
                    style = "rounded",
                },
            },
        },

        cmdline = {
            enabled = true,
            view = "cmdline_popup",
        },

        popupmenu = {
            enabled = true,
            backend = "nui",
        },

        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },

        -- Routes for filtering messages
        routes = {
            {
                filter = { event = "msg_show", find = "DAP" },
                view = "mini",
            },
            {
                filter = { event = "msg_show", find = "roslyn" },
                view = "mini",
            },
        },
    },
}
