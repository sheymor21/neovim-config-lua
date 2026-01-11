local map = vim.keymap.set

_G.lsp_on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local builtin = require("telescope.builtin")

    client.server_capabilities.semanticTokensProvider = nil
    map("n", "gd", function() Snacks.picker.lsp_definitions() end, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "grr", function() Snacks.picker.lsp_references() end, { buffer = bufnr, desc = "References" })
    map("n", "gi", function() Snacks.picker.lsp_implementations() end, { buffer = bufnr, desc = "Implementation" })
    map("n", "gt", function() Snacks.picker.lsp_type_definitions() end, { buffer = bufnr, desc = "Type Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    map("n", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("v", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
end

-- Agrega ; al final de la linea
map("n", ";", function()
    local line = vim.api.nvim_get_current_line()
    if line:match(";%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A;")
    vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Smart ; at EOL" })

-- Agrega , al final de la linea,
map("n", ",", function()
    local line = vim.api.nvim_get_current_line()
    if line:match(",%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A,")
    vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Smart , at EOL" })

-- Formatear con LSP
map("n", "<leader>mf", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format current buffer" })

map("n", "<leader>s", function()
    require("telescope.builtin").lsp_document_symbols({
        symbols = {
            "method",
            "function",
            "struct",
            "class",
            "interface",
        },
    })
end, { desc = "Document symbols (fast)" })

map("n", "<leader>tt", function()
    require("telescope.builtin").grep_string({
        search = "- [ ]",
        cwd = vim.fn.expand("~/notes"),
        prompt_title = "Pending tasks",
    })
end, { desc = "All pending tasks" })


 local Terminal = require("toggleterm.terminal").Terminal

local runner = Terminal:new({
  direction = "float",
  close_on_exit = false,
  hidden = true,
})

local function run_project()
  local ext = vim.fn.expand("%:e")
  local file = vim.fn.expand("%:p")
  local cmd

  if ext == "cs" then
    cmd = "dotnet run"

  elseif ext == "ts" or ext == "js" then
    if vim.fn.filereadable("bun.lock") == 1 then
      cmd = "bun run dev"
    elseif vim.fn.filereadable("package.json") == 1 then
      cmd = "npm start"
    else
      cmd = "node " .. file
    end

  elseif ext == "go" then
    cmd = "go run " .. file

  elseif ext == "lua" then
    cmd = "lua " .. file

  elseif ext == "html" then
    cmd = "xdg-open " .. file
  else
    vim.notify("No runner for ." .. ext, vim.log.levels.WARN)
    return
  end

  runner.cmd = cmd
  runner:toggle()
end

map("n", "<leader>cn", run_project, { desc = "Run project" })


vim.keymap.set("n", "<leader>ct", function()
    require("neotest").run.run()
end, { desc = "Test nearest" })



