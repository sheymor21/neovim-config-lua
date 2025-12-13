-- ===========================
-- GOPLS (Neovim 0.11+)
-- ===========================

local gopls_bin = "gopls"

local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()

if ok then
	capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Root segurou
local function get_root_dir(fname)
	return vim.fs.root(fname, { "go.work", "go.mod", ".git" }) or vim.loop.cwd()
end

local gopls_config = {
	name = "gopls",
	cmd = { gopls_bin },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}

-- ===========================
-- SINGLETON
-- ===========================

local gopls_client_id = nil

local function start_gopls(bufnr)
	-- Ya existe → adjuntar
	if gopls_client_id then
		local client = vim.lsp.get_client_by_id(gopls_client_id)
		if client then
			vim.lsp.buf_attach_client(bufnr, gopls_client_id)
			return
		end
	end

	-- Crear cliente
	gopls_client_id = vim.lsp.start({
		name = gopls_config.name,
		cmd = gopls_config.cmd,
		root_dir = get_root_dir(vim.api.nvim_buf_get_name(bufnr)),
		filetypes = gopls_config.filetypes,
		capabilities = gopls_config.capabilities,
		settings = gopls_config.settings,

		on_exit = function()
			gopls_client_id = nil
		end,
	})

	if gopls_client_id then
		vim.lsp.buf_attach_client(bufnr, gopls_client_id)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = function(args)
		start_gopls(args.buf)
	end,
})
