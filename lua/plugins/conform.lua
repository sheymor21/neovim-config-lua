return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier", "vtsls" },
				typescript = { "prettier", "vtsls" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
			format_on_save = true,
			stop_after_first = true,
			notify = function(msg, level)
				if pcall(require, "noice") then
					vim.schedule(function()
						require("noice").notify(msg, level)
					end)
				else
					vim.notify(msg, level)
				end
			end,
		})
	end,
}
