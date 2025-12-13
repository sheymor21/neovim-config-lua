require("telescope").load_extension("yank_history")
local map = vim.keymap.set

map("n", "<leader>y", function()
	require("telescope").extensions.yank_history.yank_history()
end, { desc = "Yank history" })
