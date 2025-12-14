local omnisharp_bin = vim.fn.stdpath("data") .. "/mason/bin/OmniSharp"

local omnisharp_config = {
	name = "omnisharp",

	cmd = {
		omnisharp_bin,
		"--languageserver",
		"--hostPID",
		tostring(vim.fn.getpid()),
	},

	filetypes = { "cs", "vb" },

	root_dir = function(fname)
		return vim.fs.root(fname, {
			"*.sln",
			"*.csproj",
			"*.vbproj",
			".git",
		}) or vim.loop.cwd()
	end,

	capabilities = require("cmp_nvim_lsp").default_capabilities(),

	settings = {
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = true,
			EnableImportCompletion = true,
			EnableDecompilationSupport = false,
			EnableEditorConfigSupport = true,
		},
	},
}

local omnisharp_client_id = nil

local function start_omnisharp(bufnr)
	if omnisharp_client_id and vim.lsp.get_client_by_id(omnisharp_client_id) then
		vim.lsp.buf_attach_client(bufnr, omnisharp_client_id)
		return
	end

	omnisharp_client_id = vim.lsp.start({
		name = omnisharp_config.name,
		cmd = omnisharp_config.cmd,
		root_dir = omnisharp_config.root_dir(vim.api.nvim_buf_get_name(bufnr)),
		filetypes = omnisharp_config.filetypes,
		capabilities = omnisharp_config.capabilities,
		settings = omnisharp_config.settings,

		on_exit = function()
			omnisharp_client_id = nil
		end,
	})

	vim.lsp.buf_attach_client(bufnr, omnisharp_client_id)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cs", "vb" },
	callback = function(args)
		start_omnisharp(args.buf)
	end,
})

-- ===========================
-- KILL FORZADO AL SALIR
-- ===========================

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		if omnisharp_client_id then
			local client = vim.lsp.get_client_by_id(omnisharp_client_id)
			if client then
				client.stop(true)
			end
		end

		-- Matar cualquier OmniSharp colgado
		vim.fn.system("pkill -f OmniSharp")
	end,
})
