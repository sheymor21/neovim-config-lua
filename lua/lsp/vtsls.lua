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
		-- Optimized check for Neovim 0.11
		if #vim.lsp.get_clients({ bufnr = args.buf, name = "vtsls" }) > 0 then
			return
		end

		vim.lsp.start({
			name = "vtsls",
			cmd = vtsls_cmd,
			capabilities = capabilities,
			-- Ensure shared keymaps are applied
			on_attach = _G.lsp_on_attach,

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
