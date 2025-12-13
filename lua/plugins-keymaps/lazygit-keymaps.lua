local lazygit = require("../config.lazygit")
local map = vim.keymap.set

map("n", "<leader>gg", lazygit.toggle, {
	desc = "LazyGit",
})
