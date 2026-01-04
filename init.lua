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

require("config.lazy")
require("config.lazy-docker")
require("config.dap-csharp")
require("config.lazygit")
require("config.theme")
require("config.indent")
require("config.filetype-theme")
require("config.neo-tree")
require("config.highlight-%")
require("config.teleskaten-config")
require("general-config")
vim.notify = require("notify")
require("telescope").load_extension("noice")
require("lsp.omnisharp")
require("lsp.gopls")
require("lsp.lua-lsp")
require("lsp.vtsls")
require("lsp.html")
require("lsp.css")
require("lsp.markdown")
require("keymaps")

