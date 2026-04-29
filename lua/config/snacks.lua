-- Snacks configuration
local Snacks = require("snacks")

-- Set vim.notify to use Snacks notifier
vim.notify = Snacks.notifier.notify

-- Override vim.ui.select and vim.ui.input to use snacks
vim.ui.select = function(items, opts, on_choice)
	Snacks.picker.select(items, opts, on_choice)
end

vim.ui.input = function(opts, on_confirm)
	Snacks.input(opts, on_confirm)
end