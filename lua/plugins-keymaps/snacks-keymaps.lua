local map = vim.keymap.set

-- LazyGit
map("n", "<leader>ig", function()
    Snacks.lazygit()
end, { desc = "LazyGit" })

-- Terminal
map("n", "<leader>tt", function()
    Snacks.terminal()
end, { desc = "Toggle Terminal" })

-- LazyDocker (using terminal)
map("n", "<leader>id", function()
    local utils = require("utils")
    if not utils.command_exists("lazydocker") then
        vim.notify("LazyDocker no está instalado", vim.log.levels.ERROR)
        return
    end
    Snacks.terminal({ "lazydocker" })
end, { desc = "LazyDocker" })

-- Picker sources
map("n", "<leader>sm", function()
    Snacks.picker.marks()
end, { desc = "Marks" })

map("n", "<leader>sh", function()
    Snacks.picker.help()
end, { desc = "Help Pages" })

map("n", "<leader>sk", function()
    Snacks.picker.keymaps()
end, { desc = "Keymaps" })

map("n", "<leader>sc", function()
    Snacks.picker.commands()
end, { desc = "Commands" })

map("n", "<leader>su", function()
    Snacks.picker.undo()
end, { desc = "Undo History" })

map("n", "<leader>sq", function()
    Snacks.picker.qflist()
end, { desc = "Quickfix List" })

map("n", "<leader>sl", function()
    Snacks.picker.loclist()
end, { desc = "Location List" })

map("n", "<leader>sr", function()
    Snacks.picker.resume()
end, { desc = "Resume Picker" })
