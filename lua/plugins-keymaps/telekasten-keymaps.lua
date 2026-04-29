local map = vim.keymap.set

-- Note operations (mirroring old Obsidian <leader>o prefix)
map("n", "<leader>on", "<cmd>Telekasten new_templated_note<CR>", { desc = "New note from template" })
map("n", "<leader>od", "<cmd>Telekasten goto_today<CR>", { desc = "Open today's daily note" })
map("n", "<leader>oD", "<cmd>Telekasten goto_yesterday<CR>", { desc = "Open yesterday's daily note" })
map("n", "<leader>ot", "<cmd>Telekasten goto_tomorrow<CR>", { desc = "Open tomorrow's daily note" })

-- Search and navigation
map("n", "<leader>os", "<cmd>Telekasten search_notes<CR>", { desc = "Search notes" })
map("n", "<leader>of", "<cmd>Telekasten find_notes<CR>", { desc = "Find notes" })
map("n", "<leader>ob", "<cmd>Telekasten show_backlinks<CR>", { desc = "Show backlinks" })
map("n", "<leader>og", "<cmd>Telekasten show_tags<CR>", { desc = "Show tags" })

-- Actions
map("n", "<leader>or", "<cmd>Telekasten rename_note<CR>", { desc = "Rename note" })
map("n", "<leader>op", "<cmd>Telekasten paste_img_and_link<CR>", { desc = "Paste image from clipboard" })
map("n", "<leader>oc", "<cmd>Telekasten toggle_todo<CR>", { desc = "Toggle checkbox / todo" })
map("n", "<leader>oT", "<cmd>Telekasten show_calendar<CR>", { desc = "Show calendar" })

-- Follow link
map("n", "<leader>ok", "<cmd>Telekasten follow_link<CR>", { desc = "Follow link" })

-- Capture quick note
map("n", "<leader>oC", "<cmd>Telekasten capture<CR>", { desc = "Capture quick note" })

-- Panel
map("n", "<leader>oo", "<cmd>Telekasten panel<CR>", { desc = "Open Telekasten panel" })

-- Markdown-specific keymaps (gf for following wiki links)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local opts = { buffer = true, silent = true }
        map("n", "gf", "<cmd>Telekasten follow_link<CR>", opts)
    end,
})
