require("plugins-keymaps.lazygit-keymaps")
require("plugins-keymaps.lazydocker-keymaps")
require("plugins-keymaps.dap-keymaps")
require("plugins-keymaps.vim-multicursor-keymaps")
require("plugins-keymaps.yanky-keymaps")
local map = vim.keymap.set

-- =========================
-- MOVIMIENTO COLEMAK-DH
-- =========================
map({ "n", "v" }, "n", "h") -- izquierda
map({ "n", "v" }, "e", "j") -- abajo
map({ "n", "v" }, "i", "k") -- arriba
map({ "n", "v" }, "o", "l") -- derecha

-- Desactivar los originales
map({ "n", "v" }, "h", "<nop>")
map({ "n", "v" }, "j", "<nop>")
map({ "n", "v" }, "k", "<nop>")
map({ "n", "v" }, "l", "<nop>")

map("n", "l", "b") -- word atrás

-- Inicio / fin de línea
map("n", "H", "^")
map("n", "L", "$")

-- Scroll cómodo
map("n", "E", "<C-d>")
map("n", "I", "<C-u>")
map("n", "h", "o")

-- =========================
-- KEYMAPS .NET
-- =========================
map("n", "gd", vim.lsp.buf.definition)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "gr", vim.lsp.buf.references)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)

map("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

-- =========================
-- KEYMAPS SYSTEM
-- =========================
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
map("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
map("n", "<leader>W", ":luafile %<CR>", { noremap = true, silent = true })

-- =========================
-- KEYMAPS SYSTEM
-- =========================

-- Archivos y búsqueda
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Buscar archivos" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Buscar texto" })
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>r", "<cmd>Telescope oldfiles<cr>", { desc = "Recientes" })

map("n", "<leader>yw", "ysiw", { remap = true })

-- LSP (MUY importante para ti)
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
map("n", "gr", "<cmd>Telescope lsp_references<cr>")
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>")
map("n", "<leader>ds", "<cmd>Telescope diagnostics<cr>")

-- Formatear con LSP
vim.keymap.set("n", "<leader>m", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format current buffer" })
