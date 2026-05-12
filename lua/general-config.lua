-- Main autocmd group for organization
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Combined BufEnter handler for buffer management
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local bt = vim.bo[args.buf].buftype

		-- Skip prompt buffers (snacks picker/input) to avoid interfering with their mode
		if bt == "prompt" then
			return
		end

		-- Oil doesn't need cleanup like neo-tree did

		-- Filetype detection
		if ft == "" then
			vim.cmd("filetype detect")
		end
		
		-- Treesitter re-attach
		if ft ~= "" then
			pcall(vim.treesitter.start, args.buf)
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
		severity = {
			min = vim.diagnostic.severity.ERROR,
		},
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Auto-convert CRLF to LF on open
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Auto-convert Windows line endings to Unix",
	callback = function()
		if vim.bo.fileformat == "dos" then
			vim.bo.fileformat = "unix"
		end
	end,
})

-- Base fold settings (ufo manages foldmethod/foldexpr)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
