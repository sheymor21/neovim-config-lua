local map = vim.keymap.set
local behavior = require("function-keymaps")

-- Notes panel
map("n", "<leader>oo", behavior.open_notes_panel, { desc = "Open notes panel" })

-- Note creation
map("n", "<leader>on", behavior.new_note_with_folder, { desc = "New note in folder" })
map("n", "<leader>oC", behavior.capture_note, { desc = "Capture quick note" })

-- Daily notes
map("n", "<leader>od", function() behavior.open_daily_note(0) end, { desc = "Open today's daily note" })
map("n", "<leader>oD", function() behavior.open_daily_note(-1) end, { desc = "Open yesterday's daily note" })
map("n", "<leader>ot", function() behavior.open_daily_note(1) end, { desc = "Open tomorrow's daily note" })

-- Search and navigation
map("n", "<leader>os", behavior.grep_notes, { desc = "Search notes" })
map("n", "<leader>of", behavior.find_notes, { desc = "Find notes" })
map("n", "<leader>ob", behavior.show_backlinks, { desc = "Show backlinks" })
map("n", "<leader>og", behavior.show_tags, { desc = "Show tags" })

-- Actions
map("n", "<leader>or", behavior.rename_note, { desc = "Rename note" })
map("n", "<leader>oc", behavior.toggle_checkbox, { desc = "Toggle checkbox" })
map("n", "<leader>ok", behavior.follow_link, { desc = "Follow link" })

-- Markdown-specific keymaps (gf for following links)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local opts = { buffer = true, silent = true }
        map("n", "gf", behavior.follow_link, opts)
    end,
})
