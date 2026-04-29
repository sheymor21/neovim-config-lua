return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({
			check_ts = true, -- usa treesitter
			enable_check_bracket_line = false,
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		})

		-- NOTE: blink.cmp handles auto-brackets via built-in semantic token matching.
	end,
}
