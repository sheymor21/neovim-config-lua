return {
	"pteroctopus/faster.nvim",
	event = "VeryLazy",
	opts = {
		enabled = true,

		threshold = {
			filesize = 200 * 1024, -- 200 KB
			lines = 5000,
		},

		timeout = 400,
		throttle = 60,
	},
}
