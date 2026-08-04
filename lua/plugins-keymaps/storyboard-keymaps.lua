local map = vim.keymap.set
local b = require("function-keymaps")

-- Story Board (DiaProject) keymaps
map("n", "<leader>tsd", b.dia_start,  { desc = "Storyboard: Start server" })
map("n", "<leader>tsD", b.dia_stop,   { desc = "Storyboard: Stop server" })
map("n", "<leader>tso", b.dia_open,   { desc = "Storyboard: Open in browser" })
map("n", "<leader>tsl", b.dia_logs,   { desc = "Storyboard: View logs" })
map("n", "<leader>tsp", b.dia_projects, { desc = "Storyboard: Projects" })
map("n", "<leader>tsn", b.dia_create_project, { desc = "Storyboard: New project" })
map("n", "<leader>tsc", b.dia_columns, { desc = "Storyboard: Columns" })
map("n", "<leader>tsk", b.dia_cards,  { desc = "Storyboard: Cards" })
