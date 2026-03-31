return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            enabled = true,
            formatters = {
                file = {
                    filename_first = true,
                    truncate = "middle",
                },
            },
            sources = {
                lsp_references = {
                    format = "file",
                },
            },
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "i", "n" } },
                    }
                }
            }
        },
        input = { enabled = true },
        scroll = { enabled = false },
        notifier = { enabled = true },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { section = "keys",   gap = 1, padding = 1 },
                { section = "startup" },
            },
            preset = {
                header = [[
   ███╗   ██╗██╗   ██╗██╗███╗   ███╗
   ████╗  ██║██║   ██║██║████╗ ████║
   ██╔██╗ ██║██║   ██║██║██╔████╔██║
   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
                keys = {
                    { icon = "󰈞 ", key = "f", desc = "Find File", action = ":Telescope find_files" },
                    { icon = "💻", key = "p", desc = "Projects", action = ":Telescope neovim-project discover" },
                    { icon = "󰊄 ", key = "g", desc = "Live Grep", action = ":Telescope live_grep" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene" },
                    { icon = " ", key = "e", desc = "Explorer", action = ":Neotree toggle" },
                    { icon = " ", key = "l", desc = "Lazy Plugins", action = ":Lazy" },
                    { icon = " ", key = "r", desc = "Restore last session", action = ":AutoSession search" },
                    { icon = "⚙ ", key = "c", desc = "Config", action = ":NeovimProjectLoad ~/.config/nvim" },
                    { icon = "󰩈 ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },
    },
}
