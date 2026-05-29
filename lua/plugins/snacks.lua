return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- Notifier (replaces nvim-notify)
        notifier = {
            enabled = true,
            timeout = 3000,
            width = { min = 40, max = 0.4 },
            height = { min = 1, max = 0.6 },
        },

        -- Dashboard (replaces alpha-nvim)
        dashboard = {
            enabled = true,
            width = 60,
            row = nil,
            col = nil,
            pane_gap = 4,
            preset = {
                -- Override all default keys (don't include the default 's' for session)
                keys = {
                    { icon = "", key = "f", desc = "Find File", action = ":FzfLua files" },
                    { icon = "", key = "p", desc = "Projects", action = ":NeovimProjectDiscover" },
                {
                    icon = "",
                    key = "v",
                    desc = "Open Vault",
                    action = ":Telekasten find_notes",
                },
                {
                    icon = "",
                    key = "n",
                    desc = "Daily Note",
                    action = ":Telekasten goto_today",
                },
                {
                    icon = "",
                    key = "N",
                    desc = "New Note",
                    action = function() require("function-keymaps").new_note_with_folder() end,
                },
                    { icon = "", key = "l", desc = "Lazy Plugins", action = ":Lazy" },
                    { icon = "", key = "u", desc = "Open URL", action = function() require("function-keymaps").dashboard_open_url() end },
                    { icon = "", key = "m", desc = "Mason", action = ":Mason" },
                    { icon = "", key = "q", desc = "Quit", action = ":qa" },
                },
                header = [[
██████╗ ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ ██████╗ ██████╗
██╔════╝ ██║  ██║██╔════╝╚██╗ ██╔╝████╗ ████║██╔═══██╗██╔══██╗
╚█████╗  ███████║█████╗   ╚████╔╝ ██╔████╔██║██║   ██║██████╔╝
 ╚═══██╗ ██╔══██║██╔══╝    ╚██╔╝  ██║╚██╔╝██║██║   ██║██╔══██╗
██████╔╝ ██║  ██║███████╗   ██║   ██║ ╚═╝ ██║╚██████╔╝██║  ██║
╚═════╝  ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝  ╚═╝  ╚═╝
                ]],
            },
            formats = {
                icon = function(item)
                    if item.icon == "💻" or item.icon == "🖥️" then
                        return { { item.icon, width = 2 } }
                    end
                    return { { item.icon .. " ", hl = "icon" } }
                end,
                footer = { "%s", align = "center" },
                header = { "%s", align = "center", hl = "header" },
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { section = "startup" },
            },
        },

        -- Picker (replaces telescope-ui-select)
        picker = {
            enabled = true,
            prompt = "   ",
            focus = "input",
            sources = {
                files = { prompt = "Files❯ " },
                buffers = { prompt = "Buffers❯ " },
                grep = { prompt = "Grep❯ " },
                help = { prompt = "Help❯ " },
                keymaps = { prompt = "Keymaps❯ " },
                commands = { prompt = "Commands❯ " },
                marks = { prompt = "Marks❯ " },
                undo = { prompt = "Undo❯ " },
                qflist = { prompt = "Quickfix❯ " },
                loclist = { prompt = "Loclist❯ " },
                select = { prompt = "Select❯ " },
            },
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                        ["<C-c>"] = { "close", mode = "i" },
                        ["<C-n>"] = { "list_down", mode = { "i", "n" } },
                        ["<C-e>"] = { "list_down", mode = { "i", "n" } },
                        ["<C-p>"] = { "list_up", mode = { "i", "n" } },
                        ["<C-i>"] = { "list_up", mode = { "i", "n" } },
                    },
                },
                list = {
                    keys = {
                        ["<Esc>"] = "close",
                        ["q"] = "close",
                        ["e"] = "list_down",
                        ["i"] = "list_up",
                    },
                },
            },
        },

        -- Indent (replaces indent-blankline.nvim) - enabled in VeryLazy
        indent = {
            enabled = false,
            indent = {
                char = "│",
                blank = " ",
            },
            scope = {
                enabled = true,
                char = "│",
            },
        },

        -- LazyGit integration
        lazygit = {
            enabled = true,
            configure = true,
            config = {
                os = { editPreset = "nvim-remote" },
                gui = { nerdFontsVersion = "3" },
            },
            win = { border = "rounded" },
        },

        -- Terminal
        terminal = {
            enabled = true,
            win = {
                position = "float",
                border = "rounded",
                wo = {
                    -- Use Normal highlight instead of NormalFloat for consistent background
                    winhighlight = "Normal:Normal,NormalFloat:Normal,SignColumn:Normal,LineNr:Normal",
                },
            },
        },

        -- Input (vim.ui.input replacement)
        input = {
            enabled = true,
            icon = "",
            win = { border = "rounded", width = 60 },
        },

        -- Picker UI select (vim.ui.select replacement)
        ui_select = {
            enabled = true,
        },

        -- Scope
        scope = { enabled = false },

        -- Words (LSP references navigation) - enabled in VeryLazy
        words = { enabled = false },

        -- Buffer delete
        bufdelete = { enabled = false },

        -- Git utilities
        git = { enabled = false },

        -- Git browse (open in browser)
        gitbrowse = { enabled = false },

        -- Zen mode
        zen = { enabled = false },
    },
    config = function(_, opts)
        require("snacks").setup(opts)
        require("config.snacks")
    end,
}
