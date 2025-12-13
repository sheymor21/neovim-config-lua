local M = {}

M.current = nil

M.apply = function(name)
	if M.current == name then
		return
	end

	-- Cargar plugin si es lazy
	require("lazy").load({ plugins = { name } })

	local ok = pcall(vim.cmd, "colorscheme " .. name)
	if ok then
		M.current = name
	end
end

return M
