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
    lazy = false,
    config = function()
        require("nvim-treesitter").setup()
        -- Install parsers synchronously on first load
        -- Note: Install runs async by default, :wait() ensures completion
        require("nvim-treesitter").install(ensure_installed)
    end,
}
