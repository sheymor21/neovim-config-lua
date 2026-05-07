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
	desc = "Clean buffers outside current project",
	callback = function()
		local cwd = vim.uv.cwd()
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

-- Folding configuration
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt_local.foldlevel = 99
		vim.opt_local.foldlevelstart = 99
		vim.opt_local.foldenable = true
	end,
})
-- Auto-enter insert mode for snacks.nvim input dialogs
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "snacks_input", "snacks_picker_input" },
	callback = function()
		vim.defer_fn(function()
			local ft = vim.bo.filetype
			if vim.fn.mode() ~= "i" and (ft == "snacks_input" or ft == "snacks_picker_input") then
				vim.cmd("startinsert!")
			end
		end, 50)
	end,
})


