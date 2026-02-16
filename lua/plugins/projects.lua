return {

    "coffebar/neovim-project",
    opts = {
        projects = {
            "~/Projects/*",
            "~/.config/nvim",
        },
        last_session_on_startup = false,

        -- Configuración de dashboard (opcional)
        dashboard_mode = false,
    },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
        { "Shatur/neovim-session-manager" },
    },
    event = "VimEnter",
    priority = 50,
}
