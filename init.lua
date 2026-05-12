vim.g.start_time = vim.fn.reltime()

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
vim.opt.timeoutlen = 700

-- Preserve UTF-8 BOM in C# files (prevents showing whole file as changed)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
        vim.opt_local.bomb = true
    end,
})

-- Branch to environment-specific init
require("init." .. (vim.g.vscode and "nvim_vscode" or "nvim"))
