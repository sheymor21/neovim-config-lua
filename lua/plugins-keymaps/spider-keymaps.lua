local map = vim.keymap.set
local spider = require("spider")

-- Spider: smarter word motion (camelCase, subwords, snake_case)
-- `e` is unavailable (remapped to `j` in Colemak-DH mode)
map({ "n", "x" }, "w", function() spider.motion("w") end, { desc = "Spider word forward" })
map({ "n", "x" }, "b", function() spider.motion("b") end, { desc = "Spider word backward" })
