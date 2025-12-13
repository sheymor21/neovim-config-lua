return {

	-- =========================
	-- MASON
	-- =========================
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "omnisharp" },
			})
		end,
	},

	-- =========================
	-- LSP FILE OPS
	-- =========================
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},

	{
		"karb94/neoscroll.nvim",
		event = "BufReadPost",
		config = function()
			require("neoscroll").setup({
				easing = "cubic", -- opcional: smoothing curve
			})
		end,
	},
}
