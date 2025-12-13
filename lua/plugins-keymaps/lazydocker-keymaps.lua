local lazydocker = require("../config.lazy-docker")
local map = vim.keymap.set

map("n", "<leader>dd", lazydocker.toggle, {
	desc = "LazyDocker",
})
