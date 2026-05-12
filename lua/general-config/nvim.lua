-- Nvim-only autocmds (extracted from general-config.lua)
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = false })

-- Aerial close for small buffers
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	callback = function()
		if vim.api.nvim_buf_line_count(0) < 50 then
			pcall(function() require("aerial").close() end)
		end
	end,
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
