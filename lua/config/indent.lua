vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "IndentBlanklineChar", { link = "Comment" })
		vim.api.nvim_set_hl(0, "IndentScope", { link = "Function" })
	end,
})
