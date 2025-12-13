local map = vim.keymap.set

-- Añadir cursores
map({ "n", "v" }, "<C-n>", "<Plug>(VM-Find-Under)", { silent = true })
map({ "n", "v" }, "<C-N>", "<Plug>(VM-Find-Subword-Under)", { silent = true })

-- Acciones con leader
map("n", "<leader>ma", "<Plug>(VM-Select-All)", { desc = "Select All Matches", silent = true })
map("n", "<leader>mm", "<Plug>(VM-Reselect-Last)", { desc = "Reselect Last", silent = true })
