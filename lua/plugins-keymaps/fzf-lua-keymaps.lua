local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fzf files" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Fzf buffers" })
map("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Fzf symbols" })
map("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "Fzf live grep" })
