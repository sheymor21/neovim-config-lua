local M = {}

-- Cache for loaded themes
M.loaded_themes = {}

-- Cache lualine module
local lualine = nil
local function get_lualine()
	if not lualine then
		local ok, mod = pcall(require, "lualine")
		if ok then
			lualine = mod
		end
	end
	return lualine
end

local function apply_lualine(theme)
	local lual = get_lualine()
	if not lual then
		return
	end

	-- Only update theme option, don't full reconfigure
	local current_config = lual.get_config and lual.get_config() or {}
	if current_config.options and current_config.options.theme ~= theme then
		current_config.options.theme = theme
		lual.setup(current_config)
	end
end

-- Refresh devicons highlights after colorscheme change
local function refresh_devicons()
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return
	end

	local icons = devicons.get_icons()
	for icon_name, icon_data in pairs(icons) do
		if icon_data.color and type(icon_data.color) == "string" and icon_data.color:match("^#%x%x%x%x%x%x$") then
			-- Get the actual highlight group name that devicons uses
			local _, hl_group = devicons.get_icon("" .. icon_name)
			if hl_group then
				pcall(vim.api.nvim_set_hl, 0, hl_group, {
					fg = icon_data.color,
					ctermfg = tonumber(icon_data.cterm_color),
				})
			end
		end
	end

	-- Set default icon highlight
	local default_icon = devicons.get_default_icon()
	if default_icon and default_icon.color and type(default_icon.color) == "string" then
		pcall(vim.api.nvim_set_hl, 0, "DevIconDefault", {
			fg = default_icon.color,
			ctermfg = tonumber(default_icon.cterm_color),
		})
	end
end

M.current = nil

M.apply = function(name)
	if M.current == name then
		return
	end

	-- Load theme plugin only if not already loaded (non-blocking)
	if not M.loaded_themes[name] then
		require("lazy").load({
			plugins = { name },
			wait = false,
		})
		M.loaded_themes[name] = true
	end

	-- Apply colorscheme
	if vim.g.colors_name ~= name then
		local ok = pcall(vim.cmd.colorscheme, name)
		if not ok then
			vim.notify("Colorscheme not found: " .. name, vim.log.levels.WARN)
			return
		end
	end

	M.current = name
	apply_lualine(name)

	-- Schedule devicons refresh after colorscheme change
	vim.schedule(function()
		refresh_devicons()
		vim.cmd("redraw!")
	end)
end

return M
