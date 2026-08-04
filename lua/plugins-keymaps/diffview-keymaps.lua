local map = vim.keymap.set

local function diffview_open(opts)
  local Diffview = require("diffview")
  if Diffview.views and Diffview.views._get_current_view() then
    vim.cmd("DiffviewClose")
    return
  end
  Diffview.open(opts)
end

map("n", "<leader>gd", function()
  diffview_open()
end, { desc = "Diffview (working changes)" })

map("n", "<leader>gD", function()
  diffview_open({ files_only = true })
end, { desc = "Diffview files (working changes)" })

map("n", "<leader>gh", function()
  require("diffview").file_history()
end, { desc = "Diffview file history" })

map("n", "<leader>gH", function()
  require("diffview").file_history({ rev = { "HEAD" } })
end, { desc = "Diffview branch history" })

map("n", "<leader>gt", function()
  require("diffview").toggle_files()
end, { desc = "Diffview toggle file panel" })
