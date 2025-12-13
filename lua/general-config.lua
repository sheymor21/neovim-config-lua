-- =========================
-- FORMAT ON SAVE
-- =========================
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ev)
		local ft = vim.bo[ev.buf].filetype
		if ft ~= "neo-tree" and ft ~= "neo-tree-popup" then
			pcall(vim.cmd, "Neotree close")
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- puedes cambiarlo
			timeout = 200,
		})
	end,
})
