local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function get_root_dir(fname)
	return vim.fs.root(fname, {
		".git",
		".marksman.toml",
		".marksman.yaml",
	}) or vim.loop.cwd()
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		vim.lsp.start({
			name = "marksman",
			cmd = { "marksman", "server" },
			root_dir = get_root_dir(args.file),
			capabilities = capabilities,
			single_file_support = true,
		})
	end,
})
