local lspconfig = require("lspconfig")
local util = lspconfig.util
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.marksman.setup({
	capabilities = capabilities,
	filetypes = { "markdown" },

	root_dir = util.root_pattern(".git", ".marksman.toml", ".marksman.yaml"),

	single_file_support = true,
})
