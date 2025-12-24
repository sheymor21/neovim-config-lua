local conform = require("conform")
local map = vim.keymap.set

map("n", "<leader>mf", function()
	conform.format({ async = true })
end, { desc = "Format current buffer" })
