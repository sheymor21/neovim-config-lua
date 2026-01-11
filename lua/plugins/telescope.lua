return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
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
                projects = {}
            },
        })

        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "projects")
    end,
}
