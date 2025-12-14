return {
	"folke/neodev.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	lazy = false,
	priority = 1000,
	config = function()
		require("neodev").setup({
			library = {
				plugins = true,
				types = true,
			},
		})
	end,
}
