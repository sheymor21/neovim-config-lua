local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fzf files" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Fzf buffers" })
map("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Fzf symbols" })
map("n", "<leader>sgg", "<cmd>FzfLua live_grep<cr>", { desc = "Fzf live grep (global)" })
map("n", "<leader>sgf", function()
	require("fzf-lua").live_grep({ search_paths = { vim.fn.expand("%:p") } })
end, { desc = "Fzf live grep (current file)" })
