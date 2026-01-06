local map = vim.keymap.set
-- Launch panel if nothing is typed after <leader>z
map("n", "<leader>zp", "<cmd>Telekasten panel<CR>")

-- Most used functions
map("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
map("n", "<leader>zv", "<cmd>Telekasten switch_vault<CR>")
map("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
map("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
map("n", "<leader>zn", "<cmd>Telekasten new_templated_note<CR>")
