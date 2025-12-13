return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			config = function()
				require("notify").setup({
					stages = "static", -- ⚡ sin animaciones pesadas
					timeout = 2500,
					fps = 60,
					background_colour = "#1e1e1e",
				})
				vim.notify = require("notify")
			end,
		},
	},

	opts = {
		-- ⚡ PERFOMANCE MODE
		render = "minimal",
		stages = "static",

		messages = {
			enabled = true,
			view = "mini",
			view_error = "mini",
			view_warn = "mini",
			view_history = "messages",
		},

		-- ✅ LSP optimizado
		lsp = {
			progress = {
				enabled = true,
				view = "mini",
			},

			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true, -- ⚡ más rápido
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- CMP sí
			},

			hover = {
				enabled = true,
				silent = true,
			},

			signature = {
				enabled = true,
			},

			message = {
				enabled = true,
			},
		},

		-- ✅ CMDLINE
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
		},

		-- ✅ POPUPS
		popupmenu = {
			enabled = true,
			backend = "nui",
		},

		-- ✅ Presets ligeros
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false, -- ⚡ off para velocidad
			lsp_doc_border = true,
		},

		-- ✅ DAP integrado
		routes = {
			{
				filter = { event = "msg_show", find = "DAP" },
				view = "mini",
			},
			{ filter = { event = "notify", find = "Invalid mapping for  e" }, opts = { skip = true } },
			{ filter = { event = "notify", find = "Invalid mapping for  i" }, opts = { skip = true } },
			{
				filter = {
					event = "msg_show",
					find = "OmniSharp",
				},
				view = "notify",
			},
			{
				filter = {
					event = "msg_show",
					find = "roslyn",
				},
				view = "notify",
			},
		},
	},
}
