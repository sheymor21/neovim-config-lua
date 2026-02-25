return {
    'sheymor21/unirunner.nvim',
    dependencies = {
        'akinsho/toggleterm.nvim',
        's1n7ax/nvim-window-picker',
    },
    lazy = true,
    config = function()
        require("unirunner").setup({
            persist = true,

            working_dir = "root",
            close_delay = 1000,
            cancel_close_delay = 2000,
            panel = {
                keymaps = {
                    down = "e",
                    up = "i",
                    view_output = "<CR>",
                    pin = "p",
                    delete = "d",
                    clear_all = "D",
                    rerun = "r",
                    close = "q",
                    -- Output viewer
                    scroll_down = "e",
                    scroll_up = "i",
                    follow = "r",
                    cancel = "c",
                    restart = "R",
                },
            },

            root_markers = {
                "package.json",
                "go.mod",
                "*.sln",
                ".git",
            },
        })
    end,
}
