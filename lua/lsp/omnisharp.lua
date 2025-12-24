local omnisharp_bin = vim.fn.stdpath("data") .. "/mason/bin/OmniSharp"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cs", "vb" },
	callback = function(args)
		-- FORCE reuse of existing client by checking if one is already running for this root
		local root = vim.fs.root(args.buf, { "*.sln", "*.csproj", ".git" })
		local existing = vim.lsp.get_clients({ name = "omnisharp" })

		for _, client in ipairs(existing) do
			if client.config.root_dir == root then
				vim.lsp.buf_attach_client(args.buf, client.id)
				return
			end
		end

		vim.lsp.start({
			name = "omnisharp",
			cmd = {
				omnisharp_bin,
				"--languageserver",
				"--hostPID",
				tostring(vim.fn.getpid()),
			},
			root_dir = root,
			capabilities = capabilities,
			on_attach = _G.lsp_on_attach,
			settings = {
				RoslynExtensionsOptions = {
					EnableAnalyzersSupport = true,
					EnableImportCompletion = true,
					EnableDecompilationSupport = false,
					EnableEditorConfigSupport = true,
				},
			},
		})
	end,
})

-- This ensures that when you quit Neovim, the dotnet processes are killed
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local clients = vim.lsp.get_clients({ name = "omnisharp" })
		for _, client in ipairs(clients) do
			client.stop()
		end
		-- Wait a moment for graceful stop, then force kill orphans if they remain
		vim.fn.system("pkill -f OmniSharp")
	end,
})

-- Handle cleanup when closing the last C# buffer
vim.api.nvim_create_autocmd("BufDelete", {
	pattern = { "*.cs", "*.vb" },
	callback = function()
		vim.schedule(function()
			local still_has_cs = false
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_valid(buf) and (vim.bo[buf].filetype == "cs" or vim.bo[buf].filetype == "vb") then
					still_has_cs = true
					break
				end
			end

			if not still_has_cs then
				local clients = vim.lsp.get_clients({ name = "omnisharp" })
				for _, client in ipairs(clients) do
					client.stop()
				end
			end
		end)
	end,
})
