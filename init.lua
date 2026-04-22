vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "
vim.g.nvim_surround_no_normal_mappings = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.o.virtualedit = ""
vim.opt_local.bomb = true

-- Preserve UTF-8 BOM in C# files (prevents showing whole file as changed)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
        vim.opt_local.bomb = true
    end,
})



require("lsp.on_attach")
require("config.lazy")
require("general-config")
require("function-keymaps")
require("keymaps")

    -- Defer non-critical modules to improve startup time
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.profiler")
        require("config.csharp-accessors")
        require("config.csharp-editorconfig")
        require("config.plugin-health")
        require("config.filetype-theme")
        require("config.lazy-docker")
        require("config.lazygit")
        require("config.dap-config")
        require("config.indent")
        require("config.telekasten-config")
        require("lsp.gopls")
        require("lsp.lua-lsp")
        require("lsp.vtsls")
        require("lsp.html")
        require("lsp.css")
        require("lsp.markdown")
    end,
})
