require("telekasten").setup({
    home = vim.fn.expand("~/notes"),

    dailies = vim.fn.expand("~/notes/daily"),
    templates = vim.fn.expand("~/notes/templates"),

    -- Configurar múltiples vaults/workspaces
    vaults = {
        personal = {
            home = vim.fn.expand("~/notes/personal"),
        },
        works = {
            home = vim.fn.expand("~/notes/works"),
        },
        projects = {
            home = vim.fn.expand("~/notes/projects"),
        },
    },

    extension = ".md",

    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,

    template_new_note = vim.fn.expand("~/notes/templates/new_note.md"),
    template_new_daily = vim.fn.expand("~/notes/templates/daily.md"),

    journal_auto_open = false,
    auto_set_filetype = false,
})

-- ~/notes/
-- ├── projects/
-- ├── areas/
-- ├── resources/
-- ├── daily/
-- ├── templates/
-- │   ├── new_note.md
-- │   └── daily.md
-- └── inbox.md
