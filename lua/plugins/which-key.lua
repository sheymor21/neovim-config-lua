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
			{ "<leader>iu", group = "Neotest", icon = "󰙨" },
			{ "<leader>iw", group = "Windows", icon = "󰖯" },
			{ "<leader>is", group = "Diagnostics", icon = "󰒡" },
			{ "<leader>r", group = "Misc", icon = "󰅴" },
			{ "<leader>c", group = "Code/Runner", icon = "󰅱" },
			{ "<leader>d", group = "Debug", icon = "󰆿" },
			{ "<leader>f", group = "Find", icon = "󰈞" },
			{ "<leader>m", group = "Multicursor", icon = "󰆿" },
			{ "<leader>y", group = "Yank/Surround", icon = "󰆏" },
			{ "<leader>z", group = "Notes", icon = "󱞂" },
			{ "<leader>t", group = "Toggle", icon = "󰔡" },
			{ "<leader>s", group = "Search", icon = "󰺮" },
			{ "<leader>a", group = "Harpoon", icon = "󰛢" },
			{ "<leader>n", group = "Nvim Status", icon = "󰒓" },
		},
	},
}
