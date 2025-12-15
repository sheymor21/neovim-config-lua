local capabilities = require("cmp_nvim_lsp").default_capabilities()

local vtsls_cmd = {
	vim.fn.stdpath("data") .. "/mason/bin/vtsls",
	"--stdio",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
	},
	callback = function(args)
		-- Evita duplicar el cliente
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if client.name == "vtsls" then
				return
			end
		end

		vim.lsp.start({
			name = "vtsls",
			cmd = vtsls_cmd,

			capabilities = capabilities,

			root_dir = vim.fs.root(args.buf, {
				"package.json",
				"tsconfig.json",
				".git",
			}),

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
		})
	end,
})
