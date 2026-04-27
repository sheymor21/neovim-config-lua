local map = vim.keymap.set

-- Note operations
map("n", "<leader>oo", "<cmd>Obsidian open<CR>", { desc = "Open Obsidian App" })
map("n", "<leader>on", function()
    vim.cmd("Obsidian new dir='ideas flash'")
end, { desc = "New note in ideas flash" })
map("n", "<leader>ou", function()
    vim.cmd("Obsidian new dir=daily")
end, { desc = "Unique note in daily" })
map("n", "<leader>od", "<cmd>Obsidian today<CR>", { desc = "Open today's daily note" })
map("n", "<leader>oD", "<cmd>Obsidian yesterday<CR>", { desc = "Open yesterday's daily note" })
map("n", "<leader>ot", "<cmd>Obsidian tomorrow<CR>", { desc = "Open tomorrow's daily note" })

-- Search and navigation
map("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Search notes" })
map("n", "<leader>of", "<cmd>Obsidian quick_switch<CR>", { desc = "Quick switch between notes" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Show backlinks" })
map("n", "<leader>ol", "<cmd>Obsidian links<CR>", { desc = "Show links" })
map("n", "<leader>og", "<cmd>Obsidian tags<CR>", { desc = "Show tags" })

-- Actions
map("n", "<leader>ow", "<cmd>Obsidian workspace<CR>", { desc = "Switch workspace" })
map("n", "<leader>or", "<cmd>Obsidian rename<CR>", { desc = "Rename note" })
map("n", "<leader>oe", "<cmd>Obsidian extract_note<CR>", { desc = "Extract text to new note" })
map("n", "<leader>op", "<cmd>Obsidian paste_img<CR>", { desc = "Paste image from clipboard" })
map("n", "<leader>oc", "<cmd>Obsidian toggle_checkbox<CR>", { desc = "Toggle checkbox" })
map("n", "<leader>oT", "<cmd>Obsidian template<CR>", { desc = "Insert template" })

-- Follow link
map("n", "<leader>ok", "<cmd>Obsidian follow_link<CR>", { desc = "Follow link" })
map("n", "<leader>oK", "<cmd>Obsidian follow_link vsplit<CR>", { desc = "Follow link in vsplit" })

-- Markdown-specific keymaps (gf for following wiki links)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local opts = { buffer = true, noremap = false, expr = true }
        map("n", "gf", function()
            if require("obsidian").util.cursor_on_markdown_link() then
                return "<cmd>Obsidian follow_link<CR>"
            else
                return "gf"
            end
        end, opts)
    end,
})
