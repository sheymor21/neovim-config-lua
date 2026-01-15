local lazydocker = require("../config.lazy-docker")
local map = vim.keymap.set

map("n", "<leader>id", lazydocker.toggle, {
	desc = "LazyDocker",
})
