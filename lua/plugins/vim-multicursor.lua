return {
	"mg979/vim-visual-multi",
	branch = "master",
	init = function()
		vim.g.VM_default_mappings = 0 -- desactiva mappings por defecto
		vim.g.VM_theme = "codedark"
	end,
}
