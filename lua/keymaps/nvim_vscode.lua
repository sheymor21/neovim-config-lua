local map = vim.keymap.set

-- VS Code native command replacements
map("n", "<leader>ff", function()
  vim.fn.VSCodeNotify("workbench.action.quickOpen")
end, { desc = "Quick open file" })

map("n", "<leader>fb", function()
  vim.fn.VSCodeNotify("workbench.action.showAllEditors")
end, { desc = "Show all editors" })

map("n", "<leader>sg", function()
  vim.fn.VSCodeNotify("workbench.action.findInFiles")
end, { desc = "Find in files" })

map("n", "<leader>ss", function()
  vim.fn.VSCodeNotify("workbench.action.gotoSymbol")
end, { desc = "Go to symbol" })

map("n", "<leader>e", function()
  vim.fn.VSCodeNotify("workbench.view.explorer")
end, { desc = "Toggle explorer" })

map("n", "<leader>tt", function()
  vim.fn.VSCodeNotify("workbench.action.terminal.toggleTerminal")
end, { desc = "Toggle terminal" })

map("n", "gd", function()
  vim.fn.VSCodeNotify("editor.action.revealDefinition")
end, { desc = "Go to definition" })

map("n", "K", function()
  vim.fn.VSCodeNotify("editor.action.showHover")
end, { desc = "Hover documentation" })

map("n", "<leader>rn", function()
  vim.fn.VSCodeNotify("editor.action.rename")
end, { desc = "Rename symbol" })

map("n", "<leader>ca", function()
  vim.fn.VSCodeNotify("editor.action.quickFix")
end, { desc = "Code action" })

map("n", "<leader>mf", function()
  vim.fn.VSCodeNotify("editor.action.formatDocument")
end, { desc = "Format document" })

map("n", "<leader>mp", function()
  vim.fn.VSCodeNotify("markdown.showPreview")
end, { desc = "Markdown preview" })

map("n", "<F5>", function()
  vim.fn.VSCodeNotify("workbench.action.debug.start")
end, { desc = "Start debug" })

map("n", "<F10>", function()
  vim.fn.VSCodeNotify("workbench.action.debug.stepOver")
end, { desc = "Step over" })

map("n", "<F11>", function()
  vim.fn.VSCodeNotify("workbench.action.debug.stepInto")
end, { desc = "Step into" })

map("n", "<F12>", function()
  vim.fn.VSCodeNotify("workbench.action.debug.stepOut")
end, { desc = "Step out" })

map("n", "<leader>ib", function()
  vim.fn.VSCodeNotify("editor.debug.action.toggleBreakpoint")
end, { desc = "Toggle breakpoint" })

-- File operations (matching standalone Neovim behavior)
map("n", "<leader>w", function()
  vim.fn.VSCodeNotify("workbench.action.files.save")
end, { desc = "Save file" })

map("n", "<leader>q", function()
  vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
end, { desc = "Close editor" })

-- Silent undo to prevent "Already at oldest change" spam in VS Code output
map("n", "u", "<cmd>silent undo<CR>", { desc = "Undo" })
map("n", "U", "<cmd>silent redo<CR>", { desc = "Redo" })
