return {
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = false,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = true,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = true,
	},
	{
		"scottmckendry/cyberdream.nvim",
		name = "cyberdream",
		config = function()
			require("cyberdream").setup({
				variant = "auto",
			})
		end,
		lazy = true,
	},
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		config = function()
			require("onedark").setup({
				style = "warmer",
			})
		end,
		lazy = true,
	},
}
