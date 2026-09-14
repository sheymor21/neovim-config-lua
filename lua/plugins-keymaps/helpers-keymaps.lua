local map = vim.keymap.set
local behavior = require("function-keymaps")

-- Helper snippets. Each list gets its own direct key under <leader>h.
-- To add a new list: define it in lua/config/helpers.lua, then copy a line
-- below and change the key + category, e.g.:
--   map("n", "<leader>hg", function() behavior.helpers_open("git") end, { desc = "Git helper" })

map("n", "<leader>hs", function() behavior.helpers_open("sql") end, { desc = "SQL helper query" })
map("n", "<leader>hl", behavior.helpers_open_config, { desc = "Edit helper config" })
map("n", "<leader>hp", behavior.create_plugin_luarc, { desc = "Create plugin .luarc.json" })

vim.api.nvim_create_user_command("PluginLuarc", behavior.create_plugin_luarc, {
    desc = "Create a minimal .luarc.json for a Neovim plugin",
})
