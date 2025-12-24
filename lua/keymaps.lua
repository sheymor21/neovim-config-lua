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

map({ "n", "v" }, "N", "H")
map({ "n", "v" }, "E", "J") -- abajo
map({ "n", "v" }, "I", "K") -- arriba
map({ "n", "v" }, "O", "L") -- derecha

-- Desactivar los originales
map({ "n", "v" }, "h", "<nop>")
map({ "n", "v" }, "j", "<nop>")
map({ "n", "v" }, "k", "<nop>")
map({ "n", "v" }, "l", "<nop>")

map({ "n", "v" }, "H", "<nop>")
map({ "n", "v" }, "J", "<nop>")
map({ "n", "v" }, "K", "<nop>")
map({ "n", "v" }, "L", "<nop>")

-- Inicio / fin de línea
map({ "n", "v" }, "N", "^")
map({ "n", "v" }, "O", "$")

-- Scroll cómodo
map("n", "E", "<C-d>")
map("n", "I", "<C-u>")

map("n", "h", "o")
map("n", "H", "O")
map("n", "k", "i")

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

-- Archivos y búsqueda
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Buscar archivos" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Buscar texto" })
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>r", "<cmd>Telescope oldfiles<cr>", { desc = "Recientes" })

map("n", "<leader>yw", "ysiw", { remap = true })

-- Asegurar filetype correcto
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
        if vim.bo[args.buf].filetype == "" then
            vim.cmd("filetype detect")
        end
    end,
})

_G.lsp_on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local map = vim.keymap.set

    client.server_capabilities.semanticTokensProvider = nil
    map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
    map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Implementation" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
end

-- Agrega ; al final de la linea
map("n", ";", function()
    local line = vim.api.nvim_get_current_line()
    if line:match(";%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A;")
    vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Smart ; at EOL" })

-- Agrega , al final de la linea,
map("n", ",", function()
    local line = vim.api.nvim_get_current_line()
    if line:match(",%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A,")
    vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Smart , at EOL" })

-- Formatear con LSP
map("n", "<leader>mf", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format current buffer" })

map("n", "<leader>s", function()
    require("telescope.builtin").lsp_document_symbols({
        symbols = {
            "method",
            "function",
            "struct",
            "class",
            "interface",
        },
    })
end, { desc = "Document symbols (fast)" })
