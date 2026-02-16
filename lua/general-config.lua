-- Main autocmd group for organization
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Set virtualedit globally once instead of on every buffer
vim.o.virtualedit = ""

-- Combined BufEnter handler for buffer management
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		
		-- Close neo-tree when leaving it
		if ft ~= "neo-tree" and ft ~= "neo-tree-popup" then
			pcall(vim.cmd, "Neotree close")
		end
		
		-- Filetype detection
		if ft == "" then
			vim.cmd("filetype detect")
		end
		
		-- Treesitter re-attach
		if ft ~= "" then
			pcall(vim.treesitter.start, args.buf)
		end
		
		-- Close aerial for small buffers
		if vim.api.nvim_buf_line_count(0) < 50 then
			pcall(function() require("aerial").close() end)
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

-- Project management: clean buffers outside current project
local last_project = nil
vim.api.nvim_create_autocmd("DirChanged", {
	group = augroup,
	desc = "Limpiar buffers fuera del proyecto actual",
	callback = function()
		local cwd = vim.loop.cwd()
		if cwd == last_project then
			return
		end
		last_project = cwd

		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf)
				and vim.fn.bufwinnr(buf) == -1
				and vim.bo[buf].buftype == "" then

				local name = vim.api.nvim_buf_get_name(buf)
				if name ~= "" and not vim.startswith(name, cwd) then
					vim.api.nvim_buf_delete(buf, {})
				end
			end
		end
	end,
})

-- Folding configuration
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt_local.foldlevel = 99
		vim.opt_local.foldlevelstart = 99
		vim.opt_local.foldenable = true
	end,
})
