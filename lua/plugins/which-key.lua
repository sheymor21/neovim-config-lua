return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",

		win = {
			border = "rounded",
			padding = { 0, 1 },
			no_overlap = true,
			title = false,

			anchor = "NW",
		},

		layout = {
			align = "right",
			spacing = 0,
		},

		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},

		show_help = false,
		show_keys = false,

		plugins = {
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},

		-- Group definitions for better organization
		spec = {
			{ "<leader>i", group = "Integration", icon = "󰌹" },
			{ "<leader>c", group = "Code/Runner", icon = "󰅱" },
			{ "<leader>o", group = "Overseer", icon = "󰑮" },
			{ "<leader>m", group = "Multicursor", icon = "󰆿" },
			{ "<leader>y", group = "Yank", icon = "󰆏" },
			{ "<leader>z", group = "Notes", icon = "󱞂" },
			{ "<leader>g", group = "Git", icon = "󰊢" },
			{ "<leader>u", group = "UI", icon = "󰙵" },
			{ "<leader>t", group = "Toggle", icon = "󰔡" },
		},
	},
}
