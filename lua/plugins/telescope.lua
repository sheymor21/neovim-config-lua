return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        -- telescope-ui-select.nvim removed - using snacks.picker instead
    },
    priority = 900,
    cmd = "Telescope",
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                prompt_prefix = "   ",
                selection_caret = " ",
                path_display = { "truncate" },

                mappings = {
                    i = {
                        ["<Esc>"] = actions.close,
                    },
                },
            },

            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                projects = {},
                -- ui-select extension removed - using snacks.picker instead
            },
        })

        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "projects")
        pcall(telescope.load_extension, "noice")
        -- ui-select extension removed - using snacks.picker instead
    end,
}
