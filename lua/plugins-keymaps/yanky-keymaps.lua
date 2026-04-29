local map = vim.keymap.set

map("n", "<leader>yh", function()
	require("telescope").load_extension("yank_history")
	require("telescope").extensions.yank_history.yank_history()
end, { desc = "Yank history" })
