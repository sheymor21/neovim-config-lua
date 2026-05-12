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

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("nvim-treesitter").setup()
        require("nvim-treesitter").install(ensure_installed)
    end,
}
