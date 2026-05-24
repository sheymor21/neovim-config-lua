local map = vim.keymap.set

map("n", "<leader>yh", function()
    require("yanky.sources.snacks").pick()
end, { desc = "Yank history" })