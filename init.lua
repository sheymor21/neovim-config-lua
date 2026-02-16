vim.opt.relativenumber = true
vim.opt.tabstop = 4;
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.o.virtualedit = ""

require("lsp.on_attach")
require("config.lazy")
require("config.theme")
vim.cmd("colorscheme kanagawa")
require("general-config")
require("function-keymaps")
require("keymaps")

-- Defer non-critical modules to improve startup time
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.csharp-accessors")
        require("config.filetype-theme")
        require("config.lazy-docker")
        require("config.lazygit")
        require("config.dap-config")
        require("config.indent")
        require("config.neo-tree")
        require("config.highlight-%")
        require("config.telekasten-config")
        require("lsp.gopls")
        require("lsp.lua-lsp")
        require("lsp.vtsls")
        require("lsp.html")
        require("lsp.css")
        require("lsp.markdown")
    end,
})
