local lazydocker = require("../config.lazy-docker")
local map = vim.keymap.set

map("n", "<leader>idd", lazydocker.toggle, {
	desc = "LazyDocker",
})
