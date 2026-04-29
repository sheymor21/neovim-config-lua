require("obsidian").setup({
    workspaces = {
        {
            name = "Sheymor",
            path = "~/Documents/Sheymor",
        },
    },
    sync = {
        enabled = true,
    },

    daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily-notes" },
        template = "daily.md",
    },

    completion = {
        min_chars = 2,
    },

    new_notes_location = "notes_subdir",

    note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
        end
        return suffix
    end,

    templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
    },

    open = {
        func = function(uri)
            vim.ui.open(uri)
        end,
    },

    picker = {
        name = "telescope.nvim",
        note_mappings = {
            new = "<C-x>",
            insert_link = "<C-l>",
        },
    },

    search = {
        sort_by = "modified",
        sort_reversed = true,
        max_lines = 1000,
    },

    open_notes_in = "current",

    ui = {
        enable = true,
        update_debounce = 200,
        max_file_length = 5000,
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianImportant = { bold = true, fg = "#d73128" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
        },
    },

    checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
    },

    attachments = {
        folder = "assets/images",
        img_name_func = function()
            return string.format("%s-", os.time())
        end,
        img_text_func = function(client, path)
            path = client:vault_relative_path(path) or path
            return string.format("![%s](%s)", path.name, path)
        end,
    },

    legacy_commands = false,

    callbacks = {
        post_setup = function(client) end,
        enter_note = function(client, note) end,
        leave_note = function(client, note) end,
        pre_write_note = function(client, note) end,
        post_write_note = function(client, note) end,
    },
})
