local function fix_neotree_highlights()
	local ok, neo = pcall(require, "neo-tree.ui.highlights")
	if not ok then
		return
	end

	neo.setup()
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("NeoTreeHighlightsFix", { clear = true }),
	callback = fix_neotree_highlights,
})
