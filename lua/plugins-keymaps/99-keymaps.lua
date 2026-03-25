local _99 = require("99")

-- Visual mode: Send selection to AI and replace with result
vim.keymap.set("v", "<leader>9v", function()
    _99.visual()
end, { desc = "99: AI replace visual selection" })

-- Normal mode: Search with AI
vim.keymap.set("n", "<leader>9s", function()
    _99.search()
end, { desc = "99: AI search" })

-- Normal mode: General AI vibe/chat
vim.keymap.set("n", "<leader>9a", function()
    _99.vibe()
end, { desc = "99: AI assistant (vibe)" })

-- Stop all in-flight requests
vim.keymap.set("n", "<leader>9x", function()
    _99.stop_all_requests()
end, { desc = "99: Stop all requests" })

-- View logs
vim.keymap.set("n", "<leader>9l", function()
    _99.view_logs()
end, { desc = "99: View logs" })

-- Open last interaction
vim.keymap.set("n", "<leader>9o", function()
    _99.open()
end, { desc = "99: Open last interaction" })

-- Clear previous requests
vim.keymap.set("n", "<leader>9c", function()
    _99.clear_previous_requests()
end, { desc = "99: Clear previous requests" })

-- Worker: Set work item
vim.keymap.set("n", "<leader>9w", function()
    _99.Extensions.Worker.set_work()
end, { desc = "99: Set work item" })

-- Worker: Search for remaining work
vim.keymap.set("n", "<leader>9r", function()
    _99.Extensions.Worker.search()
end, { desc = "99: Search remaining work" })
