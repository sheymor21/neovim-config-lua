local lazygit = require("../config.lazygit")
local map = vim.keymap.set

map("n", "<leader>ig", lazygit.toggle, {
	desc = "LazyGit",
})
