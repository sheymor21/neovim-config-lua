local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").vtsls.setup({
	capabilities = capabilities,
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },

	settings = {
		vtsls = {
			autoUseWorkspaceTsdk = true,
		},

		typescript = {
			format = {
				semicolons = "insert",
				tabSize = 2,
			},
			preferences = {
				importModuleSpecifier = "relative",
			},
		},

		javascript = {
			format = {
				semicolons = "insert",
				tabSize = 2,
			},
		},
	},

	root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	callback = function(args)
		local clients = vim.lsp.get_clients({ bufnr = args.buf })
		for _, c in ipairs(clients) do
			if c.name == "vtsls" then
				return
			end
		end
		vim.lsp.start({ name = "vtsls" })
	end,
})
