return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("ibl").setup({
			indent = {
				char = "│", -- guía de indent
				tab_char = "│",
			},

			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
				include = {
					node_type = {
						lua = { "function", "if_statement", "for_statement" },
						javascript = { "function", "if_statement" },
						typescript = { "function", "if_statement" },
					},
				},
			},
			whitespace = {
				remove_blankline_trail = true,
			},

			exclude = {
				filetypes = {
					"help",
					"terminal",
					"dashboard",
					"lazy",
					"mason",
					"notify",
					"noice",
					"Trouble",
					"nvimtree",
					"neo-tree",
				},
				buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
			},
		})

		-- Highlights (compatibles con themes)
		vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3b4261" })
		vim.api.nvim_set_hl(0, "IndentScope", { fg = "#7aa2f7", bold = true })
	end,
}
