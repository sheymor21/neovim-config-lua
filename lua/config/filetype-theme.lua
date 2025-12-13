-- lua/config/filetype-theme.lua
local theme = require("config.theme")

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		-- ❌ ignora buffers internos
		if vim.bo[args.buf].buftype ~= "" then
			return
		end

		local ft = vim.bo[args.buf].filetype
		if ft == "" then
			return
		end
		local themes_by_ft = {
			lua = "kanagawa",
			go = "onedark",
			cs = "gruvbox",
			html = "tokyonight",
			css = "gruvbox",
			javascript = "tokyonight",
			typescript = "tokyonight",
		}

		theme.apply(themes_by_ft[ft] or "gruvbox")
	end,
})
