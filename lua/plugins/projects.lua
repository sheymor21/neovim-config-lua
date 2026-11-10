return {

    "coffebar/neovim-project",
    opts = {
        projects = {
            "~/Projects/kaptas/*",
            "~/Projects/espinosa/*",
            "~/Projects/assismanager/*",
            "~/Projects/personal/*",
            "~/Projects/universal/universal.dev/AssisManager/*",
            "~/Projects/universal/universal.dev/cobranza/*",
            "~/Projects/universal/universal.espinosa/cobranza/*",
            "~/.config/nvim",
            "~/.config/opencode/plugins/*"
        },
        last_session_on_startup = false,

        -- Dashboard configuration (optional)
        dashboard_mode = false,

        -- Use snacks.nvim picker instead of telescope
        picker = {
            type = "snacks",
        },
    },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "folke/snacks.nvim" },
        { "Shatur/neovim-session-manager" },
    },
    event = "VimEnter",
    priority = 50,
}
