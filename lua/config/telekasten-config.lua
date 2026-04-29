require("telekasten").setup({
    home = vim.fn.expand("~/Documents/Sheymor"),

    dailies = vim.fn.expand("~/Documents/Sheymor/daily"),
    weeklies = vim.fn.expand("~/Documents/Sheymor/weekly"),
    templates = vim.fn.expand("~/Documents/Sheymor/templates"),

    extension = ".md",

    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    template_new_note = vim.fn.expand("~/Documents/Sheymor/templates/new_note.md"),
    template_new_daily = vim.fn.expand("~/Documents/Sheymor/templates/daily.md"),
    template_new_weekly = vim.fn.expand("~/Documents/Sheymor/templates/weekly.md"),

    journal_auto_open = false,
    auto_set_filetype = false,

    -- Obsidian-compatible link style
    link_format = "[[filename|title]]",
    link_style = "wiki",

    -- Media/paste support
    media_extensions = {
        ".png", ".jpg", ".jpeg", ".gif", ".webp", ".pdf", ".mp3", ".mp4",
    },

    -- Subdirs for attachments (Obsidian-compatible)
    image_subdir = "assets/images",
    media_previewer = "telescope-media-files",
})
