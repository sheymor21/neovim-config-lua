return {
	"gbprod/yanky.nvim",
	dependencies = {
		"kkharji/sqlite.lua",
	},
	event = "VeryLazy",
	config = function()
		require("yanky").setup({
			ring = {
				history_length = 50,
				storage = "sqlite",
				sync_with_numbered_registers = true,
			},
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 200,
			},
		})
	end,
}
