local ensure_installed = {
    "lua",
    "go",
    "html",
    "css",
    "scss",
    "json",
    "javascript",
    "typescript",
    "c_sharp",
    "regex",
    "bash",
}

local treesitter_config = {
    ensure_installed = ensure_installed,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true,
    },
    fold = {
        enable = true
    }

}

return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    event = { "BufReadPost", "BufNewFile" },

    config = function()
        require("nvim-treesitter.configs").setup(treesitter_config)
    end,
}
