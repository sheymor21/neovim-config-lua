return {
    'sheymor21/unirunner.nvim',
    dependencies = {
        'akinsho/toggleterm.nvim',
        's1n7ax/nvim-window-picker',
    },
    lazy = true,
    config = function()
        require('unirunner').setup({
            persist = true,

            working_dir = 'root',
            close_delay = 1000,
            cancel_close_delay = 2000,

            root_markers = {
                'package.json',
                'go.mod',
                '*.sln',
                '.git',
            },
        })
    end,
}
