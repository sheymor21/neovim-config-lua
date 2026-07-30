local map = vim.keymap.set
local b = require("function-keymaps")

-- Story Board (DiaProject) keymaps
map("n", "<leader>dd", b.dia_start,  { desc = "Storyboard: Start server" })
map("n", "<leader>dD", b.dia_stop,   { desc = "Storyboard: Stop server" })
map("n", "<leader>do", b.dia_open,   { desc = "Storyboard: Open in browser" })
map("n", "<leader>dl", b.dia_logs,   { desc = "Storyboard: View logs" })
map("n", "<leader>dp", b.dia_projects, { desc = "Storyboard: Projects" })
map("n", "<leader>dn", b.dia_create_project, { desc = "Storyboard: New project" })
map("n", "<leader>dc", b.dia_columns, { desc = "Storyboard: Columns" })
map("n", "<leader>dk", b.dia_cards,  { desc = "Storyboard: Cards" })
