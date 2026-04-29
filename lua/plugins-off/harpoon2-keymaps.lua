local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local ui = require("harpoon").ui

-- Añadir archivo a Harpoon
map("n", "<leader>aa", function()
	local harpoon = require("harpoon")
	harpoon:list():add()
	local filename = vim.fn.expand("%:t")
	vim.notify("Harpoon: " .. filename .. " added", vim.log.levels.INFO)
end, vim.tbl_extend("force", opts, { desc = "Harpoon: add file" }))

-- Toggle quick menu de Harpoon
map("n", "<leader>ah", function()
	ui:toggle_quick_menu(require("harpoon"):list())
end, vim.tbl_extend("force", opts, { desc = "Harpoon: toggle menu" }))

-- Navegar a marks 1-4
map("n", "<C-1>", function()
	require("harpoon"):list():select(1)
end, opts)
map("n", "<C-2>", function()
	require("harpoon"):list():select(2)
end, opts)
map("n", "<C-3>", function()
	require("harpoon"):list():select(3)
end, opts)
map("n", "<C-4>", function()
	require("harpoon"):list():select(4)
end, opts)

-- Telescope nativo para marks
map("n", "<leader>as", function()
	require("telescope").extensions.harpoon.marks()
end, vim.tbl_extend("force", opts, { desc = "Harpoon: Telescope marks" }))
