local M = {}

local function apply_lualine(theme)
	local ok, lualine = pcall(require, "lualine")
	if not ok then
		return
	end

	lualine.setup({
		options = {
			theme = theme,
		},
	})

	lualine.refresh()
end



M.current = nil

M.apply = function(name)
	if M.current == name then
		return
	end

	require("lazy").load({
		plugins = { name },
		wait = true,
	})

	vim.schedule(function()
		if vim.g.colors_name == name then
			return
		end

		local ok = pcall(vim.cmd.colorscheme, name)
		if not ok then
			vim.notify("Colorscheme not found: " .. name, vim.log.levels.WARN)
		end
        apply_lualine(name)
	end)
end

return M
