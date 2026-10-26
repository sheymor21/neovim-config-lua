vim.g.start_time = vim.fn.reltime()

vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "
vim.g.external_terminal = "alacritty"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.o.virtualedit = ""
vim.opt.timeoutlen = 700

-- C# files are saved as UTF-8 without a BOM. CSharpier is configured with
-- `charset = utf-8` (see csharp-editorconfig.lua); this keeps Neovim from
-- re-adding a BOM on save.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
        vim.opt_local.bomb = false
    end,
})

-- Branch to environment-specific init
require("init." .. (vim.g.vscode and "nvim_vscode" or "nvim"))
