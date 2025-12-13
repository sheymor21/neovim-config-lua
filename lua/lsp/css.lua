-- ===========================
-- CSS LSP (Mason)
-- ===========================

local css_bin = vim.fn.stdpath("data") .. "/mason/bin/vscode-css-language-server"

-- Capabilities (cmp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Root dir seguro
local function get_root_dir(fname)
	local root = vim.fs.root(fname, { "package.json", ".git" })
	return root or vim.loop.cwd()
end

-- Config base
local css_config = {
	name = "cssls",
	cmd = { css_bin, "--stdio" },
	filetypes = { "css", "scss", "less" },
	capabilities = capabilities,

	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}

-- ===========================
-- SINGLETON (1 cliente global)
-- ===========================

local css_client_id = nil

local function start_css(bufnr)
	-- Si el cliente ya existe → solo adjuntar
	if css_client_id then
		local existing = vim.lsp.get_client_by_id(css_client_id)
		if existing then
			vim.lsp.buf_attach_client(bufnr, css_client_id)
			return
		end
	end

	-- Crear nuevo cliente
	css_client_id = vim.lsp.start({
		name = css_config.name,
		cmd = css_config.cmd,
		root_dir = get_root_dir(vim.api.nvim_buf_get_name(bufnr)),
		filetypes = css_config.filetypes,
		capabilities = css_config.capabilities,
		settings = css_config.settings,

		on_exit = function()
			css_client_id = nil
		end,
	})

	if css_client_id then
		vim.lsp.buf_attach_client(bufnr, css_client_id)
	end
end

-- Auto iniciar en archivos CSS
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "css", "scss", "less" },
	callback = function(args)
		start_css(args.buf)
	end,
})
