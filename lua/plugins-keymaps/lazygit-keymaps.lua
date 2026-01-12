local lazygit = require("../config.lazygit")
local map = vim.keymap.set

map("n", "<leader>igg", lazygit.toggle, {
	desc = "LazyGit",
})
