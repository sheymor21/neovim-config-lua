return {
    "s1n7ax/nvim-window-picker",
    config = function()
        require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
                bo = {
                    filetype = { "neo-tree", "NvimTree", "dap-repl" },
                    buftype = { "terminal" },
                },
            },
            hint = "floating-big-letter",
            highlight = "WarningMsg",
        })
    end,
}
