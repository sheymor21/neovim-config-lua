return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    cmd = "Neotree",

    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,

            filesystem = {
                bind_to_cwd = true,
                follow_current_file = {
                    enabled = true,
                },
                use_libuv_file_watcher = true,
                async_directory_scan = "always",
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
            },

            window = {
                width = 32,
                mappings = {
                    ["e"] = "move_cursor_down",
                    ["i"] = "move_cursor_up",
                    ["n"] = "open",
                    ["q"] = "close_window",

                    ["f"] = "fuzzy_finder",
                    ["/"] = "filter_on_submit",
                    ["<esc>"] = "clear_filter",
                    ["a"] = "add",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                },
            },
        })
    end,
}
