return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"netcoredbg",
			},
		},
		config = function()
			require("mason").setup()
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "omnisharp", "marksman", "vtsls", "html", "cssls", "jsonls" },
			})
		end,
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},
}
