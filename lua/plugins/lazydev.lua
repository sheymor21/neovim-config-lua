return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "lazy.nvim",          words = { "LazySpec" } },
            {
                path = "plenary.nvim",
                enabled = function(root_dir)
                    return root_dir ~= vim.fn.expand("~/.config/nvim")
                end,
            },
        },
        enabled = function(root_dir)
            return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
        end,
    },
}
