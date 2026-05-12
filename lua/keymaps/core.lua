local map = vim.keymap.set
local behavior = require("function-keymaps")

-- =========================
-- COLEMAK-DH MOVEMENT
-- =========================
map({ "n", "v" }, "n", "h") -- left
map({ "n", "v" }, "e", "j") -- down
map({ "n", "v" }, "i", "k") -- up
map({ "n", "v" }, "o", "l") -- right

map({ "n", "v" }, "E", "J") -- down
map({ "n", "v" }, "I", "K") -- up
map({ "n", "v" }, "O", "L") -- right

-- Disable original keys
map({ "n", "v" }, "h", "<nop>")
map({ "n", "v" }, "j", "<nop>")
map({ "n", "v" }, "k", "<nop>")
map({ "n", "v" }, "l", "<nop>")

map({ "n", "v" }, "H", "<nop>")
map({ "n", "v" }, "J", "<nop>")
map({ "n", "v" }, "K", "<nop>")
map({ "n", "v" }, "L", "<nop>")

-- Start / end of line
map({ "n", "v" }, "N", "^")
map({ "n", "v" }, "O", "$")

-- Comfortable scroll
map("n", "E", "<C-d>")
map("n", "I", "<C-u>")

map("n", "h", "o")
map("n", "H", "O")
map("n", "k", "i")

map("n", "zn", "zc")
map("n", "zN", "zM")
map("n", "zO", "zR")

-- =========================
-- KEYMAPS SYSTEM
-- =========================
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "Close file" })
map("n", "<leader>W", ":luafile %<CR>", { noremap = true, silent = true, desc = "Run Lua" })
map("n", "<leader>j", behavior.jump_to_line, { desc = "Jump to line number" })

map("n", "<leader>yw", "ysiw", { remap = true })
map("n", "ys", "<Plug>(nvim-surround-normal)", {desc = "Add a surrounding pair around a motion (normal mode)"})
map("n", "ds", "<Plug>(nvim-surround-delete)", {desc = "Delete a surrounding pair"})
map("n", "cs", "<Plug>(nvim-surround-change)", {desc = "Change a surrounding pair"})

map("n", ";", behavior.add_dot, { desc = "Smart ; at EOL" })
map("n", ",", behavior.add_coma, { desc = "Smart , at EOL" })

-- Flash keymaps
map({"n", "x", "o"}, "f", behavior.flash_jump, { desc = "Flash jump" })
map({"n", "x", "o"}, "F", behavior.flash_treesitter, { desc = "Flash treesitter" })
