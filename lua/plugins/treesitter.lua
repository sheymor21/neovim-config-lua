return {
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",

	event = { "BufReadPost", "BufNewFile" }, -- lazy loading real

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- lenguajes base
				"lua",
				"go",
				"html",
				"css",
				"scss",
				"json",

				-- JS / TS (IMPORTANTES)
				"javascript",
				"typescript",

				-- C#
				"c_sharp",

				-- necesarios para noice.nvim
				"regex",
				"bash",
			},

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},
		})
	end,
}
