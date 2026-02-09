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
require("config.csharp-accessors")
require("config.filetype-theme")
vim.cmd("colorscheme kanagawa")
require("config.lazy-docker")
require("config.dap-config")
require("config.lazygit")
require("config.indent")
require("config.neo-tree")
require("config.highlight-%")
require("config.telekasten-config")
require("general-config")
vim.notify = require("notify")
require("telescope").load_extension("noice")
require("function-keymaps")
require("lsp.gopls")
require("lsp.lua-lsp")
require("lsp.vtsls")
require("lsp.html")
require("lsp.css")
require("lsp.markdown")
require("keymaps")
