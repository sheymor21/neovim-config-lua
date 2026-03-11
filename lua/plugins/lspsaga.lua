return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			-- UI configuration
			ui = {
				border = "rounded",
				code_action = "💡",
			},

			-- Diagnostic navigation and display (main feature)
			diagnostic = {
				show_code_action = true,
				show_source = true,
				jump_num_shortcut = true,
				diagnostic_only_current = false,
				keys = {
					exec_action = "o",
					quit = "q",
					toggle_or_jump = "<CR>",
					quit_in_show = { "q", "<ESC>" },
				},
			},

			-- Lightbulb for code actions
			lightbulb = {
				enable = true,
				sign = true,
				virtual_text = false,
				debounce = 10,
				sign_priority = 20,
			},

			-- Disable features we don't use (using Snacks instead)
			finder = {
				enable = false,
			},
			definition = {
				enable = false,
			},
			hover = {
				enable = false,
			},
			code_action = {
				enable = false,
			},
			outline = {
				enable = false,
			},
			rename = {
				enable = false,
			},
			symbol_in_winbar = {
				enable = false,
			},
			implement = {
				enable = false,
			},

			-- Beacon highlight on jump
			beacon = {
				enable = true,
				frequency = 7,
			},
		})
	end,
}
