local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Add file to Grapple
map("n", "<leader>aa", function()
  require("grapple").toggle()
end, vim.tbl_extend("force", opts, { desc = "Grapple: toggle file" }))

-- Open Grapple popup
map("n", "<leader>ah", function()
  require("grapple").open_tags()
end, vim.tbl_extend("force", opts, { desc = "Grapple: open tags" }))

-- Navigate to tags 1-4
map("n", "<C-1>", function()
  require("grapple").select({ index = 1 })
end, opts)
map("n", "<C-2>", function()
  require("grapple").select({ index = 2 })
end, opts)
map("n", "<C-3>", function()
  require("grapple").select({ index = 3 })
end, opts)
map("n", "<C-4>", function()
  require("grapple").select({ index = 4 })
end, opts)

-- Telescope integration for Grapple
map("n", "<leader>as", function()
  require("grapple").open_tags()
end, vim.tbl_extend("force", opts, { desc = "Grapple: open tags menu" }))
